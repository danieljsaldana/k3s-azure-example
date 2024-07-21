# Desplegar una Máquina en Azure con Terraform e Instalar k3s

Este repositorio contiene los archivos necesarios para desplegar una máquina virtual en Azure utilizando Terraform e instalar k3s en ella.

## Estructura del Repositorio

El repositorio está compuesto por los siguientes archivos:

1. **main.tf**: Contiene la definición del proveedor de Azure y los recursos necesarios (grupo de recursos, red virtual, subred, grupo de seguridad, IP pública, interfaz de red, máquina virtual, cuenta de almacenamiento y extensión de máquina virtual).
2. **variables.tf**: Define las variables necesarias para personalizar el despliegue (nombres, ubicaciones, tamaños, claves SSH, etc.).
3. **outputs.tf**: Define los outputs que Terraform mostrará al finalizar la ejecución (dirección IP pública de la máquina virtual).
4. **terraform.tfvars**: Archivo donde se asignan los valores a las variables definidas en `variables.tf`.

## Requisitos Previos

- Tener una cuenta de Azure.
- Tener instalado [Terraform](https://www.terraform.io/downloads.html).
- Tener configurada una clave SSH. Si no tienes una, puedes generarla con el siguiente comando:

  ```bash
  ssh-keygen -t rsa -b 4096 -C "tu-email@dominio.com"
  ```

## Configuración

1. Clonar el repositorio:

   ```bash
   git clone https://github.com/danieljsaldana/k3s-azure.git
   cd k3s-azure
   ```

2. Editar el archivo `terraform.tfvars` y completar los valores necesarios, incluyendo la clave pública SSH generada.

## Despliegue de la Infraestructura

1. Inicializar Terraform:

   ```bash
   terraform init
   ```

2. Previsualizar el plan de ejecución:

   ```bash
   terraform plan
   ```

3. Aplicar el plan para crear la infraestructura:

   ```bash
   terraform apply
   ```

## Conexión a la Máquina Virtual

Después de desplegar la máquina virtual, puedes conectarte a ella mediante SSH usando la dirección IP pública que se muestra al finalizar el proceso de Terraform.

Por ejemplo, si la dirección IP pública es `20.50.30.10`, utiliza el siguiente comando para conectarte:

```bash
ssh k3s@20.50.30.10 -i ~/.ssh/id_rsa
```

## Configuración del Cluster k3s

Una vez conectado, puedes encontrar el archivo de configuración del cluster en la siguiente ruta: `/etc/rancher/k3s/k3s.yaml`. 

### Editar el Archivo de Configuración

Abre el archivo y busca la línea que contiene `server: https://127.0.0.1:6443`. Reemplaza `127.0.0.1` con la dirección IP pública de tu servidor. El resultado debería ser algo como:

```yaml
apiVersion: v1
clusters:
- cluster:
    server: https://20.50.30.10:6443
    certificate-authority-data: ...
```

### Copiar el Archivo de Configuración a tu Máquina Local

Para interactuar con el cluster k3s desde tu máquina local, necesitarás copiar el archivo de configuración `k3s.yaml` a tu máquina. Puedes hacerlo usando `scp`. Por ejemplo:

```bash
scp k3s@20.50.30.10:/etc/rancher/k3s/k3s.yaml ~/.kube/config
```

Este comando copiará el archivo de configuración del cluster a `~/.kube/config` en tu máquina local. Asegúrate de que el directorio `.kube` exista en tu home directory.

## Opciones de Configuración Posterior

### Opción 1: Regenerar Certificados con IP Pública

En algunos casos, puede que necesites regenerar los certificados de k3s para incluir la IP pública. Para ello, sigue estos pasos:

1. **Detener k3s**:

   ```bash
   sudo systemctl stop k3s
   ```

2. **Editar el archivo de configuración**:

   Abre (o crea) el archivo `/etc/rancher/k3s/config.yaml` y añade lo siguiente:

   ```yaml
   tls-san:
     - "10.0.0.4"
     - "10.43.0.1"
     - "127.0.0.1"
     - "::1"
     - "<tu-direccion-ip-publica>"
   ```

3. **Reiniciar k3s**:

   ```bash
   sudo systemctl start k3s
   ```

## Contribuir

Si deseas contribuir a este proyecto, por favor abre un issue o un pull request en el repositorio.

## Licencia

Este proyecto está licenciado bajo los términos de la licencia MIT.

---

Para más detalles y el código completo, visita el [Repositorio de Código Terraform para k3s en Azure](https://github.com/danieljsaldana/k3s-azure).