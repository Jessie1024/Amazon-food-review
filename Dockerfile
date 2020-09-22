FROM rocker/verse
MAINTAINER Qianhui Yang <jessy1024qh@gmail.com>
RUN R -e "install.packages('tidytext')"
RUN R -e "install.packages('kableExtra')"
RUN R -e "install.packages('formattable')"
RUN R -e "install.packages('textdata')"
RUN R -e "webshot::install_phantomjs()"
RUN R -e "install.package('topicmodels')
RUN R -e "install.package('tm')
RUN R -e "install.package('plotly')
RUN R -e "install.package('circlize')
RUN R -e "install.package('ggrepel')
RUN R -e "install.package('gridExtra')
RUN apt-get update
RUN apt-get -y install ne 
