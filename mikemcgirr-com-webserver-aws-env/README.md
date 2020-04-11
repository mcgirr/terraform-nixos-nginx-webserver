# A Terraform project that creates the AWS infrastructure for a basic webserver on NixOS 

## TODO

- Add more of a description to the README
- Update the install script with variables for the portion that makes the initial /var/www/{directory-name}
- Set up a Makefile rule to run init.sh on the initial webserver creation
- Then a Makefile rule/target for uploading the lastest site
  The site is currently at ../../mikemcgirr-com/_site
  So the script could copy it from there (and probably restart nginx) 
- Add ASG support and add an explanation/write up for that 
