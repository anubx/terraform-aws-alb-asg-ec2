#!/bin/bash

yum install docker -y
service docker start
usermod -a -G docker ec2-user
id ec2-user
newgrp docker
mkdir -p /usr/local/apache2/htdocs/public_html
cat <<'EOF' > /usr/local/apache2/htdocs/public_html/index.html
<!DOCTYPE html>
<html lang="en" >
<head>
  <meta charset="UTF-8">
  <title>Terraform Demo</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.css" integrity="sha256-PF6MatZtiJ8/c9O9HQ8uSUXr++R9KBYu4gbNG5511WE=" crossorigin="anonymous" />

<link href="https://fonts.googleapis.com/css?family=Open+Sans:400,500|Saira+Semi+Condensed:300,500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="./style.css">

</head>
<body>
<!-- partial:index.partial.html -->
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
</head>

<body>
  <header id="nav-wrapper">
    <nav id="nav">
      <div class="nav left">
        <span class="gradient skew"><h1 class="logo un-skew"><a href="#home">Terraform Demo</a></h1></span>
        <button id="menu" class="btn-nav"><span class="fas fa-bars"></span></button>
      </div>
      <div class="nav right">
        <a href="#home" class="nav-link active"><span class="nav-link-span"><span class="u-nav">Home</span></span></a>
        <a href="#about" class="nav-link"><span class="nav-link-span"><span class="u-nav">About</span></span></a>
        <a href="#work" class="nav-link"><span class="nav-link-span"><span class="u-nav">Work</span></span></a>
        <a href="#contact" class="nav-link"><span class="nav-link-span"><span class="u-nav">Contact</span></span></a>
      </div>
    </nav>
  </header>
  <main>
    <section id="home">

    </section>
    <section id="about">

    </section>
    <section id="work">

    </section>
    <section id="contact">

    </section>
  </main>

</body>

</html>
<!-- partial -->
  <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js'></script><script  src="./script.js"></script>

</body>
</html>
EOF
cat <<'EOF' > /usr/local/apache2/htdocs/public_html/style.css
/*-------------Reset-------------*/
button {
  background: none;
  box-shadow: none;
  border: none;
  cursor: pointer;
}

button:focus,
input:focus {
  outline: 0;
}

html {
  scroll-behavior: smooth;
}

/*-------------Layout-------------*/
body {
  line-height: 1.5em;
  padding: 0;
  margin: 0;
}

section {
  height: 100vh;
}

#home {
  background-color: #ddd;
}

#about {
  background-color: #aaa;
}

#work {
  background-color: #888;
}

#contact {
  background-color: #666;
}

/*-------------Helpers-------------*/
.skew {
  transform: skew(-20deg);
}

.un-skew {
  transform: skew(20deg);
}

/*-------------Nav-------------*/
#nav-wrapper {
  overflow: hidden;
  width: 100%;
  margin: 0 auto;
  position: fixed;
  top: 0;
  left: 0;
  z-index: 100;
}

#nav {
  background-color: #fff;
  box-shadow: 0px 3px 10px rgba(0, 0, 0, 0.1);
  display: flex;
  flex-direction: column;
  font-family: "Saira Semi Condensed", sans-serif;
  height: 4em;
  overflow: hidden;
}
#nav.nav-visible {
  height: 100%;
  overflow: auto;
}

.nav {
  display: flex;
  height: 4em;
  line-height: 4em;
  flex-grow: 1;
}

.nav-link,
.logo {
  padding: 0 1em;
}

span.gradient {
  background: #3949AB;
  background: -webkit-linear-gradient(45deg, #3949AB, #1976D2);
  background: linear-gradient(45deg, #3949AB, #1976D2);
  padding: 0 1em;
  position: relative;
  right: 1em;
  margin-right: auto;
}
span.gradient:hover {
  animation-name: logo-hover;
  animation-duration: 0.3s;
  animation-fill-mode: forwards;
  animation-timing-function: cubic-bezier(0.17, 0.57, 0.31, 0.85);
}

h1.logo {
  font-weight: 300;
  font-size: 1.75em;
  line-height: 0.75em;
  color: #fff;
}

h1.logo a, a:active, a:hover, a:visited {
  text-decoration: none;
  color: #fff;
}

.nav-link {
  text-transform: uppercase;
  text-align: center;
  border-top: 0.5px solid #ddd;
}

a:link, a:visited, a:active {
  text-decoration: none;
  color: #3949AB;
}

a:hover {
  text-decoration: underline;
}

.right {
  display: flex;
  flex-direction: column;
  height: 100%;
}

.btn-nav {
  color: #3949AB;
  padding-left: 2em;
  padding-right: 2em;
}

@media (min-width: 800px) {
  #nav-wrapper {
    overflow: hidden;
  }

  #nav {
    overflow: hidden;
    flex-direction: row;
  }

  .nav-link {
    border-top: none;
  }

  .right {
    overflow: hidden;
    flex-direction: row;
    justify-content: flex-end;
    position: relative;
    left: 1.5em;
    height: auto;
  }

  .btn-nav {
    display: none;
  }

  .nav a:link.active, a:visited.active, a:active.active {
    background: #3949AB;
    background: -webkit-linear-gradient(45deg, #3949AB, #1976D2);
    background: linear-gradient(45deg, #3949AB, #1976D2);
    color: #fff;
  }

  .nav-link-span {
    transform: skew(20deg);
    display: inline-block;
  }

  .nav-link {
    transform: skew(-20deg);
    color: #777;
    text-decoration: none;
  }
  .nav-link:last-child {
    padding-right: 3em;
  }

  a:hover.nav-link:not(.active) {
    color: #444;
    background: #ddd;
    background: linear-gradient(45deg, #fff, #ddd);
  }
}
@keyframes logo-hover {
  20% {
    padding-right: 0em;
  }
  100% {
    padding-right: 5em;
  }
}
EOF
cat <<'EOF' > /usr/local/apache2/htdocs/public_html/script.js
var util = {
  mobileMenu() {
    $("#nav").toggleClass("nav-visible");
  },
  windowResize() {
    if ($(window).width() > 800) {
      $("#nav").removeClass("nav-visible");
    }
  },
  scrollEvent() {
    var scrollPosition = $(document).scrollTop();
    
    $.each(util.scrollMenuIds, function(i) {
      var link = util.scrollMenuIds[i],
          container = $(link).attr("href"),
          containerOffset = $(container).offset().top,
          containerHeight = $(container).outerHeight(),
          containerBottom = containerOffset + containerHeight;

      if (scrollPosition < containerBottom - 20 && scrollPosition >= containerOffset - 20) {
        $(link).addClass("active");
      } else {
        $(link).removeClass("active");
      }
    });
  }
};

$(document).ready(function() {
  
  util.scrollMenuIds = $("a.nav-link[href]");
  $("#menu").click(util.mobileMenu);
  $(window).resize(util.windowResize);
  $(document).scroll(util.scrollEvent);
  
});
EOF
chmod 755 /usr/local/apache2/htdocs/public_html/index.html
cd /usr/local/apache2/htdocs/public_html
docker run -dit --name my-apache-app -p 8080:80 -v "$PWD":/usr/local/apache2/htdocs/ httpd:2.4

