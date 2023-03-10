pipeline {
    agent {  label 'master' }
    environment {
        SSM = "/demo/terraform/${AWS_ENV}"
    }
    parameters {
        choice choices: ['tf-demo-1', 'tf-demo-2'], description: 'Select app name', name: 'APP_NAME'
        choice choices: ['dev', 'uat', 'prd'], description: 'Select an AWS account', name: 'AWS_ENV'
        choice choices: ['us-east-1', 'us-west-2'], description: 'Select an AWS region', name: 'AWS_REGION'
        choice choices: ['apply', 'destroy'], description: 'Deploy or destroy', name: 'TERRAFORM'
    }
    stages {
        stage("Set Environment") {
            steps {
                script {
                    switch(env.AWS_ENV) {
                    case 'dev':
                        env.TF_STATE_BUCKET="${TF_STATE_BUCKET_US_EAST_1}"
                        env.TF_STATE_OBJECT_KEY="terraform.tfstate"
                        env.TF_LOCK_DB="demo-tf-lock-table"
                        break
                    case 'uat':
                        env.TF_STATE_BUCKET="${TF_STATE_BUCKET_US_EAST_1}"
                        env.TF_STATE_OBJECT_KEY="terraform.tfstate"
                        env.TF_LOCK_DB="demo-tf-lock-table"
                        break
                    case 'prd':
                        env.TF_STATE_BUCKET="${TF_STATE_BUCKET_US_WEST_2}"
                        env.TF_STATE_OBJECT_KEY="terraform.tfstate"
                        env.TF_LOCK_DB="demo-tf-lock-table"
                        break     
                    }
                }
            }
        }
        stage('Install Terraform') {
            steps {
                // dir('.tfenv') {
                //     checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/tfutils/tfenv.git']]])
                // }
                sh '''
                    rm -rf .tfenv
                    git clone --depth=1 https://github.com/tfutils/tfenv.git .tfenv
                    echo 'export PATH="$WORKSPACE/.tfenv/bin:$PATH"' > ~/.bash_profile
                    . ~/.bash_profile
                    tfenv install latest
                    tfenv use latest
                    terraform --version
                '''
            }
        }

        stage('Create TFVARS File') {
            steps {
                withAWSParameterStore(credentialsId: '', naming: 'basename', path: "${SSM}", recursive: true, regionName: "us-east-1") {
                    sh '''
                        rm -rf terraform_${AWS_ENV}.tfvars .terraform
cat << TFVARS > ./terraform_${AWS_ENV}.tfvars
app_name = "${APP_NAME}"
cidr = "${CIDR}"
private_subnets = ${PRIVATE_SUBNETS}
public_subnets = ${PUBLIC_SUBNETS}
TFVARS
cat terraform_${AWS_ENV}.tfvars
                    '''
                }
            }
            post {
                success {
                    stash name: "tfvars", includes: "terraform_${AWS_ENV}.tfvars"
                }
            }
        }

        stage('Deploy Demo App') {
             when {
                environment name: 'TERRAFORM', value: 'apply'
            }
            steps {
                unstash "tfvars"
                withAWS(profile: 'default', region: "${AWS_REGION}") {
                    sh """
                        . ~/.bash_profile
                        terraform init \
                        -backend=true \
                        -backend-config key="${TF_STATE_OBJECT_KEY}" \
                        -backend-config bucket="${TF_STATE_BUCKET}" \
                        -backend-config dynamodb_table="${TF_LOCK_DB}" \
                        -force-copy
                        terraform workspace select ${AWS_ENV} || terraform workspace new ${AWS_ENV}
                        terraform plan -var-file=terraform_${AWS_ENV}.tfvars -out=tfplan -input=false
                        terraform apply --auto-approve tfplan
                    """
                }
            }
        }

        stage('Destroy Demo App') {
             when {
                environment name: 'TERRAFORM', value: 'destroy'
            }
            steps {
                unstash "tfvars"
                withAWS(profile: 'default', region: "${AWS_REGION}") {
                    sh """
                        . ~/.bash_profile
                        terraform init \
                        -backend=true \
                        -backend-config key="${TF_STATE_OBJECT_KEY}" \
                        -backend-config bucket="${TF_STATE_BUCKET}" \
                        -backend-config dynamodb_table="${TF_LOCK_DB}" \
                        -force-copy
                        terraform workspace select ${AWS_ENV} || terraform workspace new ${AWS_ENV}
                        terraform destroy -var-file=terraform_${AWS_ENV}.tfvars --auto-approve
                    """
                }
            }
        }
    }
}
