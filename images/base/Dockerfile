ARG BASEOS=debian:unstable
FROM $BASEOS
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install sudo jq yq --no-install-recommends

RUN ZDOTDIR="/etc/skel" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) "
WORKDIR /tmp

COPY required_tools.yaml .
COPY verify-tools.sh .
RUN chmod a+x ./verify-tools.sh
RUN echo $PATH
RUN ./verify-tools.sh required_tools.yaml
