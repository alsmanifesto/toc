# TOC: Go + MongoDB App

Proof of concept to test some of the technologies used in modern software development.

Go, MongoDB, Docker, Concourse, Alpine, Terraform, Ansible, Kubernetes, Google Compute Engine, Load Balancers.

## 0. Installing dependencies

Required dependencies:

 * Docker

Automatically downloaded dependencies:

 * [Go v1.8](https://golang.org/dl/)
 * [MongoDB v3.4.3](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-os-x/)
 * [httprouter](https://github.com/julienschmidt/httprouter)
 * [bson] (gopkg.in/mgo.v2/bson)
 * [mgo.v2](gopkg.in/mgo.v2)

<!-- Download the latest MongoDB release through the shell:
```
curl -O https://fastdl.mongodb.org/osx/mongodb-osx-x86_64-3.4.2.tgz
```
Extract the files from the downloaded archive:
```
tar -zxvf mongodb-osx-x86_64-3.4.2.tgz
```
Copy the extracted folder to the location from which MongoDB will run:
```
mkdir -p mongodb
cp -R -n mongodb-osx-x86_64-3.4.2/ mongodb
```
Ensure the location of the binaries is in the PATH variable:
The MongoDB binaries are in the bin/ directory of the archive. To ensure that the binaries are in your PATH, you can modify your PATH.
You can add the following line to your shell’s rc file (e.g. ~/.bashrc):
```
export PATH=<mongodb-install-directory>/bin:$PATH
```
Create the data directory:
```
mkdir -p /data/db
```
Set permissions for the data directory:
```
sudo chmod 0755 /data/db && sudo chown $USER /data/db
```
Run MongoDB:
```
mongod
``` -->
# Execute inside folder where Dockerfile is placed
docker build -t="kalamastra/go-mongo-toc" .
docker run -p <what public port the container maps to 8000:8000> -d <image>


## 1. Compilación

```
cd toc/app
```
```
go build -o toc
```
## 2. Ejecución
```bash
./toc
```

Esto generará un servidor escuchando en el puerto 3000 ( _[http://localhost:3000](http://localhost:3000)_ )

## Dockerfile:
docker build -t kalamastra/go-mongo-toc .
docker run -d --name mongo -p 27017:27017 kalamastra/go-mongo-toc

## 3. Rutas
1 Creación de una aplicación sencilla en go. (Un servicio web que reciba json y yaml y devuelva json o yaml según la petición. La idea es montar un recurso con enfoque RESTFul por ejemplo de Persona con tres campos Id, nombre, apellidos que permita las operaciones estandard y que mantenga la información de personas en memoria)

2 Hacer los scripts para construir la aplicación y testearla tanto para Linux como para Mac

3 Automatizar el proceso de build y testing usando Concourse en local

4 Crear una imagen Docker para el despliegue de la aplicación basada en Alpine

4 Automatizar con concourse el proceso de creación de la imagen y subida a un Registry remoto (puede ser dockerhub)

5 Despliegue de la aplicación en Google Compute Cloud. 

6 Aprovisionar la infraestructura usando Terraform (usar imagen base CentOS)

7 Automatizar la instalación de software necesario con Ansible (por ejemplo instalación de Docker)

8 Desplegar la imagen construida en esta infra

9 Orquestar load balancers para permitir el cambio de versión sin downtime

10 Automatizar este proceso de aprovisionamiento y despliegue de nueva versión también desde Concourse

11 Realizar el mismo despliegue usando Kubernetes en GKE en vez de aprovisionar directamente la infra automatizado como otro pipeline de Concourse

+ + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +
<!-- MongoDB -->

brew update
brew install mongodb

# Create the directory in the default location by running
$ mkdir -p /data/db
# Make sure that the /data/db directory has the right permissions by running
$ sudo chown -R `id -un` /data/db
# Enter your password

#Run the Mongo daemon
$ mongod
# Run the Mongo shell
$ mongo
||
$ cd Downloads
$ mv mongodb-osx-x86_64-3.0.7.tgz ~/
# Extract MongoDB from the the downloaded archive, and change the name of the directory to something more palatable
$ cd ~/ > tar -zxvf mongodb-osx-x86_64-3.0.7.tgz > mv mongodb-osx-x86_64-3.0.7 mongodb
# Create the directory where Mongo will store data
$ mkdir -p /data/db
# Make sure that the /data/db directory has the right permissions
$ sudo chown -R `id -un` /data/db
# Enter your password

# Run the Mongo daemon
~/mongodb/bin/mongod
# Run the Mongo shell, with the Mongo daemon running in one terminal 
~/mongodb/bin/mongo

<!-- GO  -->

# Install gvm
$ bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
# Install the latest go version (as of this writing)
$ gvm install go1.4
# Set it as active, and the default choice
$ gvm use go1.4 --default
# Local version of go installed, our GOPATH and PATH are setup, and we have access to the go executable
$ mkdir -p ~/src/go/{bin,pkg,src}
# pkgsets allows you to define separate "workspaces" and group a set of go projects using the same go version
# Create the pkgset
$ gvm pkgset create work
# Set it as active, and the default choice
$ gvm pkgset use work --default
# Let's setup a directory for our code, say ~/src/go. (Or something else)
$ mkdir -p ~/src/go/{bin,pkg,src}
# We could manually set GOPATH and PATH to be prefixed with our new "src" directory, but there's a better way. We'll use the "gvm pkgenv" command with our fresh "work" pkgset so that our new workspace will always be found in GOPATH.

#Enter the following to pull open the environment variables for the work pkgset. We'll be changing the GOPATH and PATH variables to look at ~/src/go. Obviously, adjust your entries to reflect the directory structure on your machine.
# Pull open the environment in our favoriate editor
$ gvm pkgenv work
export GVM_ROOT; GVM_ROOT="/Users/swhite/.gvm"  
export gvm_go_name; gvm_go_name="go1.4"  
export gvm_pkgset_name; gvm_pkgset_name="global"  
export GOROOT; GOROOT="$GVM_ROOT/gos/go1.4"  
export GOPATH; GOPATH="$GVM_ROOT/pkgsets/go1.4/global"  
export GVM_OVERLAY_PREFIX; GVM_OVERLAY_PREFIX="${GVM_ROOT}/pkgsets/go1.4/global/overlay"  
export PATH; PATH="${GVM_ROOT}/pkgsets/go1.4/global/bin:${GVM_ROOT}/gos/go1.4/bin:${GVM_OVERLAY_PREFIX}/bin:${GVM_ROOT}/bin:${PATH}"  
export LD_LIBRARY_PATH; LD_LIBRARY_PATH="${GVM_OVERLAY_PREFIX}/lib:${LD_LIBRARY_PATH}"  
export DYLD_LIBRARY_PATH; DYLD_LIBRARY_PATH="${GVM_OVERLAY_PREFIX}/lib:${DYLD_LIBRARY_PATH}"  
export PKG_CONFIG_PATH; PKG_CONFIG_PATH="${GVM_OVERLAY_PREFIX}/lib/pkgconfig:${PKG_CONFIG_PATH}"  
export gvm_pkgset_name="blog"

# Prefix with our go path we created
export GOPATH; GOPATH="$HOME/src/go:/Users/swhite/.gvm/pkgsets/go1.4/blog:$GOPATH"

# Prefix with the bin directory in our gopath
export PATH; PATH="$HOME/src/go/bin:/Users/swhite/.gvm/pkgsets/go1.4/blog/bin:$PATH"

# Package Set-Specific Overrides
export GVM_OVERLAY_PREFIX; GVM_OVERLAY_PREFIX="${GVM_ROOT}/pkgsets/go1.4/blog/overlay"  
export PATH; PATH="/Users/swhite/.gvm/pkgsets/go1.4/blog/bin:${GVM_OVERLAY_PREFIX}/bin:${PATH}"  
export LD_LIBRARY_PATH; LD_LIBRARY_PATH="${GVM_OVERLAY_PREFIX}/lib:${LD_LIBRARY_PATH}"  
export DYLD_LIBRARY_PATH; DYLD_LIBRARY_PATH="${GVM_OVERLAY_PREFIX}/lib:${DYLD_LIBRARY_PATH}"  
export PKG_CONFIG_PATH; PKG_CONFIG_PATH="${GVM_OVERLAY_PREFIX}/lib/pkgconfig:${PKG_CONFIG_PATH}" 

$ gvm pkgset use work
# Get packages
$ go get github.com/julienschmidt/httprouter
$ got get gopkg.in/mgo.v2/bson

$ mkdir -p ~/go/src/toc/

$ mkdir models

# Run server
$ go run server.go

curl http://localhost:3000/test

curl -XPOST -H 'Content-Type: application/json' -d '{"name": "Dale Anderson", "gender": "male", "age": 34}' http://localhost:3000/user

curl http://localhost:3000/user/58fa74e74e8d7e01fd7c4ad3

curl -XDELETE http://localhost:3000/user/58fa6d45cfb4f069066d99ae

TOC:

curl -XPOST -H 'Content-Type: application/json' -d '{"email": "hectolimar@gmail.com","pass":"123456","name":"Hector Arturo Guzmán Villalvazo","contact_pic":"https://media.licdn.com/mpr/mpr/shrinknp_400_400/AAEAAQAAAAAAAAgYAAAAJDg0NDE0YmZiLWIyZDktNDg1YS04MTBjLWRjZGNjYWRhZjE4ZA.jpg","place_we_met":"Campus Party México 2015","phone":5215545130805,"address":"Lago Ginebra 60, Cuauhtémoc Pensil, Miguel Hidalgo, 11490, CDMX","occupation":"Engineer","company":"Oracle","company_logo":"https://media.licdn.com/mpr/mpr/shrink_200_200/AAEAAQAAAAAAAAlFAAAAJGZhZDM0YjQ2LTJkNWItNDFhMS1iN2M2LTZjZjM5ODFhZTFlNg.png","start_date":"nov 2017","finish_date":"dic 2018","school_name":"Instituto Politécnico Nacional","school_logo":"https://media.licdn.com/mpr/mpr/shrink_200_200/p/1/005/010/3c3/12414a7.png","degree":"Ing. Biónica"}' http://localhost:3000/user