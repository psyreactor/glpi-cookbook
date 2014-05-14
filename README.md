Glpi Cookbook
===============

This cookbook install glpi from the source code.
####The GLPI Proyect
"GLPI is the Information Resource-Manager with an additional Administration- Interface. You can use it to build up a database with an inventory for your company (computer, software, printers...). It has enhanced functions to make the daily life for the administrators easier, like a job-tracking-system with mail-notification and methods to build a database with basic information about your network-topology."

The principal functionalities of the application are :

1. the precise inventory of all the technical resources. All their characteristics will be stored in a database.
1. management and the history of the maintenance actions and the bound procedures. This application is dynamic and is directly connected to the users who can post requests to the technicians. An interface thus authorizes the latter with if required preventing the service of maintenance and indexing a problem encountered with one of the technical resources to which they have access.

Requirements
------------
#### Cookbooks:

- yum-epel - https://github.com/opscode-cookbooks/yum-epel
- apache2 - https://github.com/onehealth-cookbooks/apache2
- mysql - https://github.com/opscode-cookbooks/mysql
- database - https://github.com/opscode-cookbooks/database


The following platforms and versions are tested and supported using Opscode's test-kitchen.

- CentOS 5.8, 6.3

The following platform families are supported in the code, and are assumed to work based on the successful testing on Ubuntu and CentOS.


- Red Hat (rhel)
- Fedora
- Amazon Linux

Recipes
-------
####glpi:default
