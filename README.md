# Despliegue con Terraform de un entorno Wordpress con alta disponibilidad y recuperación ante desastres

## Tecnologías empleadas

- Azure
- Terraform
- Ansible
- Wordpress
- Docker

## Descripción

Despliegue de una infraestructura de alta disponibilidad en Azure con Wordpress, configurado con Ansible

Compuesto por:

- Microsoft Azure Subscription
- 2 máquinas virtuales con Wordpress
- 1 balanceador de carga
- 1 base de datos MySQL

## Requisitos

Para poder realizar el despliegue completo necesitaremos:
- Suscripción de Microsoft Azure.
- Service Principal configurado en la suscripción de Azure.
- Windows Subsystem for Linux (WSL) con las siguientes herramientas instaladas:
    - Azure CLI.
    - Ansible.
    - SSHPass.
    - Terraform.

## Pasos a seguir

1. Accedemos a Azure Portal y registramos una nueva aplicación en Azure Active Directory, que en nuestro caso será para Terraform. Para ello, accedemos a Azure Active Directory y seleccionamos App registrations. Una vez dentro, pulsamos en New registration. 

  ![image](https://github.com/Legnakra/azure_ha_wordpress/assets/98739593/fdac42b3-4aba-499b-bea0-3e345a6eabe2)

2. Clonar el repositorio en la máquina local.

```bash
git clone https://github.com/Legnakra/azure_ha_wordpress.git
```

3. Dentro de la carpeta del repositorio, nos dirigimos a Scrips/Vault, donde se encontrarán los dos scripts encargados de encriptar y desencriptar los archivos con datos sensibles, los cuales se han protegido haciendo uso de Ansible Vault, el cual emplea AES256 como algoritmo.

4. Tras esto, ejecutamos primero el script *decrypt.sh*, el cual solicitará una contraseña y dejará disponible los ficheros para su uso.

![image](https://github.com/Legnakra/azure_ha_wordpress/assets/98739593/c69ba24d-5bea-41f2-9703-b7d69ac8dc20)

5. A continuación, acudimos al directorio Scripts/Terraform, donde están alojados los tres scripts encargados de operar la plataforma.  Los scripts son los siguientes:
    - plan.sh: Será el encargado de inicializar el directorio del entorno de Terraform y mostrar la salida del comando terraform plan, el cual mostrará los cambios que realizará en el entorno de Azure.
    - apply.sh: Este nos permitirá desplegar los cambios mostrados por el script anterior. 
    - destroy.sh: Por último, este permitirá destruir el entorno al completo.

    Y los ejecutamos por orden.
      - Ejecutamos el script *plan.sh*.
        ![image](https://github.com/Legnakra/azure_ha_wordpress/assets/98739593/469970a6-c051-4c9b-917d-7388666a62ab)
        ![image](https://github.com/Legnakra/azure_ha_wordpress/assets/98739593/7b2901c1-4037-40e0-9ad7-d0bd54448e4a)

      - Ejecutamos el script *apply.sh*.
        ![image](https://github.com/Legnakra/azure_ha_wordpress/assets/98739593/cd742178-ed7a-45e0-9fed-087896ed4292)
        ![image](https://github.com/Legnakra/azure_ha_wordpress/assets/98739593/af7733da-bb1a-41ab-a432-488387e04922)

    Ya desplegada nuestra infraestructura, como podemos visualizar en Azure Portal, procederemos a la creación y configuración de las IPs públicas que irán asociadas a las tarjetas de red de cada una de las máquinas virtuales de nuestra infraestructura. 

6. Accedemos dentro del grupo de recursos y en el banner superior clicamos en *Crear* y seleccionamos *Dirección IP pública*. Una vez dentro, rellenamos los campos.

    Y pulsamos en *Revisar y crear*.

7. Repetimos el proceso para la segunda IP pública.

  ![image](https://github.com/Legnakra/azure_ha_wordpress/assets/98739593/099cca0f-969d-4dca-893b-651857dbac41)

8. Ya creadas ambas IPs públicas, se las asignamos a las máquinas virtuales de nuestra infraestructura.

  ![image](https://github.com/Legnakra/azure_ha_wordpress/assets/98739593/61d7dd2e-06eb-484e-b0cb-f0cc8ae3fa00)

9. El entorno dispone de un grupo de seguridad de red asociado actuando como una suerte de firewall en el cual, Terraform despliega por defecto los puertos 80 y 442 como accesibles desde Internet. 
    Dado que Ansible hace uso del protocolo SSH para realizar cambios, añadiremos de manera temporal el puerto 22 como accesible de forma pública.

  ![image](https://github.com/Legnakra/azure_ha_wordpress/assets/98739593/41b441f3-15df-4282-adeb-af8a3f5b7b2d)

10. Nos dirigiremos a las dos IPs públicas que hemos creado y conservamos ambas IP que copiaremos en el fichero hosts que se encontrará dentro del directorio Ansible/inventories. 
  ![image](https://github.com/Legnakra/azure_ha_wordpress/assets/98739593/dbf375b4-8f6c-4a95-a3b4-1760fae8710f)
  ![image](https://github.com/Legnakra/azure_ha_wordpress/assets/98739593/1a446ed6-0294-47b5-9ef5-3d14f58ab551)

11. Una vez realizado el cambio, nos dirigimos al direcorio de *Scripts* donde encontraremos el script *deploy.sh* que se encargará de desplegar la configuración de Ansible en las máquinas virtuales.

  ![image](https://github.com/Legnakra/azure_ha_wordpress/assets/98739593/87ee55bb-203b-4773-9805-ed7ddbe14bd5)
  ![image](https://github.com/Legnakra/azure_ha_wordpress/assets/98739593/7b2d729d-91ae-4ae7-b4da-d26eb6d1dfd5)

12.	Una vez ejecutado correctamente el playbook, se desasociarán y eliminarán las direcciones IPs públicas temporales de las dos máquinas virtuales, y se eliminará la regla que permite el tráfico por el puerto 22 del grupo de seguridad de red.

  ![image](https://github.com/Legnakra/azure_ha_wordpress/assets/98739593/cd709258-63fe-47e3-b712-5a24e9e3a4c5)
  ![image](https://github.com/Legnakra/azure_ha_wordpress/assets/98739593/b348620b-ce2c-4529-8cf2-3097f6f6a925)

13. Una vez realizado exitosamente, procederemos a tomar la IP que se nos muestra en el balanceador de carga.

  ![image](https://github.com/Legnakra/azure_ha_wordpress/assets/98739593/fe43d0af-6464-4333-9c0b-a85ed4dac27e)

14.	Esta dirección la necesitaremos para configurar un registro DNS para que, cuando accedamos a *mariatec.es* nos redirija a la página principal de nuestro WordPress desplegado en Azure con Terraform y Ansible.

  ![image](https://github.com/Legnakra/azure_ha_wordpress/assets/98739593/e6ef58de-166b-4fd4-b330-eb0ff6a74c4d)

15. Una vez hemos esperado a que los servidores DNS actualicen los registros, si accedemos mediante cualquier navegador a la dirección mariatec.es podremos comprobar que disponemos del entorno WordPress perfectamente desplegado y configurado en alta disponibilidad.

  ![image](https://github.com/Legnakra/azure_ha_wordpress/assets/98739593/2a24ff3e-a0c6-47e7-b3fb-ff42f587bacb)

  NOTA 1: Este entorno se puede configurar mediante SSL haciendo uso de https, pero dado que el objetivo principal del proyecto radica en mostrar la flexibilidad de la nube y las capacidades del trabajo conjunto de Ansible y Terraform, se ha decidido no incluir dicha configuración en el proyecto.

17. Para finalizar, procederemos a ejecutar el script destroy.sh alojado en Scripts/Terraform cuya función será destruir por completo toda la infraestructura desplegada. 
  ![image](https://github.com/Legnakra/azure_ha_wordpress/assets/98739593/33b1214b-daf5-4ed4-a42d-9b885c2018fe)

  ![image](https://github.com/Legnakra/azure_ha_wordpress/assets/98739593/e318e963-b9ae-41ff-b639-5755e20b4993)

