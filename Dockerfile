FROM rocker/verse
MAINTAINER Qianhui Yang <jessy1024qh@gmail.com>
RUN R -e "install.packages('tidytext')"
RUN R -e "install.packages('kableExtra')"
RUN R -e "install.packages('formattable')"
RUN R -e "install.packages('textdata')"
RUN R -e "webshot::install_phantomjs()"