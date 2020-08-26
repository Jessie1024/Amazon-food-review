BIOS611 Project1
========================================
Food Review Analysis
-------------------------------------------

The project including an analysis of the food review in Amazon

Using This Porject
-------------------------------------------

you will need Docker and the ability to run Docker as your current user.

    >docker build . -t project1-env
    >docker run -v 'pwd:/home/rstudio -p 8787:8787 -e PASSWORD=<yourpassword> -t project1-env