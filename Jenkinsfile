pipeline {
    agent {  label 'master' }
    environment {
        SSM = "/demo/terraform/${AWS_ENV}"
    }
    parameters {
        choice choices: ['dev', 'uat', 'prd'], description: 'Select an AWS account', name: 'AWS_ENV'
        string(name: 'VPC_NAME', defaultValue: '', description: 'Enter name for VPC')
        choice choices: ['us-east-1', 'us-east-2', 'us-west-1'], description: 'Select an AWS region', name: 'AWS_REGION'
        choice choices: ['apply', 'destroy'], description: 'Deploy or destroy', name: 'TERRAFORM'
    }
    stages {
        // stage("Set Environment") {
        //     steps {
        //         script {
        //             switch(env.AWS_ENV) {
        //             case 'dev':
        //                 env.AWS_ROLE = "${DEV_ROLE_ARN}"
        //                 env.AWS_ACCT = "${DEV_AWS_ACCT}"
        //                 break
        //             case 'uat':
        //                 env.AWS_ROLE = "${DEV_ROLE_ARN}"
        //                 env.AWS_ACCT = "${DEV_AWS_ACCT}"
        //                 break
        //             case 'prd':
        //                 env.AWS_ROLE = "${STAGING_ROLE_ARN}"
        //                 env.AWS_ACCT = "${STAGING_AWS_ACCT}"
        //                 break     
        //             }
        //         }
        //     }
        // }
        stage('Install Terraform') {
            steps {
                // dir('.tfenv') {
                //     checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/tfutils/tfenv.git']]])
                // }
                sh '''

                    echo "test 123"
                    less ~/.bash_profile
                '''
            }
        }
//         stage('Deploy VPC') {
//              when {
//                 environment name: 'TERRAFORM', value: 'apply'
//             }
//             steps {
//                 withAWSParameterStore(credentialsId: 'aws_keys', naming: 'basename', path: "${SSM}", recursive: true, regionName: 'us-west-2') {
//                     sh '''
//                         cd aws-resources/create-vpc
//                         . ~/.bash_profile
//                         rm -rf terraform_${AWS_ENV}.tfvars .terraform

// cat << TFVARS > ./terraform_${AWS_ENV}.tfvars
// name = "${VPC_NAME}"
// cidr = "${CIDR}"
// private_subnets = ${PRIVATE_SUBNETS}
// public_subnets = ${PUBLIC_SUBNETS}
// database_subnets = ${DATABASE_SUBNETS}
// elasticache_subnets = ${ELASTICACHE_SUBNETS}
// intra_subnets = ${INTRANET_SUBNETS}
// TFVARS
                       
//                     '''
//                 }
//                 withAWS(roleAccount: "${AWS_ACCT}", role: "${AWS_ROLE}", region: "${AWS_REGION}") {
//                     sh '''
//                         cd aws-resources/create-vpc
//                         . ~/.bash_profile
//                         terraform init -backend-config=backend-${AWS_ENV}.tfvars -force-copy
//                         terraform workspace select ${AWS_ENV} || terraform workspace new ${AWS_ENV}
//                         terraform plan -var-file=terraform_${AWS_ENV}.tfvars -out=tfplan -input=false
//                         terraform apply --auto-approve tfplan
//                     '''
//                 }
//             }
//         }

//         stage('Destroy VPC') {
//              when {
//                 environment name: 'TERRAFORM', value: 'destroy'
//             }
//             steps {
//                 withAWSParameterStore(credentialsId: 'aws_keys', naming: 'basename', path: "${SSM}", recursive: true, regionName: 'us-west-2') {
//                     sh '''
//                         cd aws-resources/create-vpc
//                         . ~/.bash_profile
//                         rm -rf terraform_${AWS_ENV}.tfvars .terraform

// cat << TFVARS > ./terraform_${AWS_ENV}.tfvars
// name = "${VPC_NAME}"
// cidr = "${CIDR}"
// private_subnets = ${PRIVATE_SUBNETS}
// public_subnets = ${PUBLIC_SUBNETS}
// database_subnets = ${DATABASE_SUBNETS}
// elasticache_subnets = ${ELASTICACHE_SUBNETS}
// intra_subnets = ${INTRANET_SUBNETS}
// TFVARS
                       
//                     '''
//                 }
//                 withAWS(roleAccount: "${AWS_ACCT}", role: "${AWS_ROLE}", region: "${AWS_REGION}") {
//                     sh '''
//                         cd aws-resources/create-vpc
//                         . ~/.bash_profile
//                         terraform init -backend-config=backend-${AWS_ENV}.tfvars -force-copy
//                         terraform workspace select ${AWS_ENV} || terraform workspace new ${AWS_ENV}
//                         terraform destroy -var-file=terraform_${AWS_ENV}.tfvars --auto-approve
//                     '''
//                 }
//             }
        // }
    }
}
