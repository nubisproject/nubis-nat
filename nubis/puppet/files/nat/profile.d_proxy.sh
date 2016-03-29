# This overrides the value set in nubis-base
export http_proxy="http://localhost:3128/"
export https_proxy="http://localhost:3128/"
export no_proxy="localhost,127.0.0.1,.localdomain,10.0.0.0/8,169.254.169.254"
export HTTP_PROXY="$http_proxy"
export HTTPS_PROXY="$https_proxy"
export NO_PROXY="$no_proxy"
