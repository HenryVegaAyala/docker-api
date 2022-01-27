## Docker optimizado

Ambiente de producción

* Servicios externos
  * Mysql 5.7.33
  * Redis
  * Nginx
  * PHP 7.2

* Volumen
  * Appbk code

Consideraciones: El .env se debe configurar en base a necesidad de puertos disponibles, 
el horizon y el cron solo se activa si en el .env se coloca estado de **1** que significa activado. 

## Requisitos del servidor

 - Docker
 - Docker Compose
 
## Instalación

    cd my/project/dir
    cp .env.example .env
    docker-compose up --build -d
    
## Acceso bash al docker

    docker exec -it docker_app bash 

## Ver funcionamiento de los contenedores

    docker ps  
