BIOS611 Project1
========================================
Food Review Analysis
-------------------------------------------

The project including an analysis of the food review in Amazon

Using This Porject
-------------------------------------------

you will need Docker and the ability to run Docker as your current user.

    >docker build . -t project1-env
    >docker run -v /home/jessieyy/storage/bios611-project1
	:/home/rstudio -p 8787:8787 -e PASSWORD=mypassword -i project1-env
