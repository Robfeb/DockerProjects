[[_TOC_]]
# Docker Projects
### Azure Devops Agent on Container
#### Create a folder where the files will be located (You could keep them in the git repo folder if you want: jumtp to 'Steps')

`mkdir C:\dockeragent`

- Enter into the folder

`cd C:\dockeragent`

- Copy start.ps1 and dockerfile files into it

- Download last vs_buildtools.exe (if it is not on the folder) from 
https://docs.microsoft.com/en-us/visualstudio/install/create-an-offline-installation-of-visual-studio?view=vs-2019
####Steps
- Run the command

 `docker build -t buildserver:latest .`
 
 -Once installed and created run the command:

 `docker-compose up`
