# README

# Proyecto de Tienda

## Versión de Ruby
3.2.6

## Dependencias del sistema
Las puede conocer ejecutando el comando `bundle list`.

## Creación e Inicialización de la base de datos
Para inicializar la base de datos, se debe ejecutar el comando `bin/rails db:setup`. Este comando creará la base de datos, ejecutará las migraciones y cargará los datos iniciales definidos en el archivo `seeds.rb`.

El archivo `seeds.rb` se encarga de asegurar la existencia de los registros necesarios para que la aplicación funcione correctamente.

## Servicios
Para la búsqueda y filtrado de productos se usó la gema `ransack`. Para más información visitar [Documentación](https://github.com/activerecord-hackery/ransack).

## Instrucciones de despliegue

1. Clonar el repositorio:
    ```sh
    git clone https://github.com/santiFie/FitStore-Manager.git
    cd store-proyect
    ```

2. Instalar las dependencias:
    ```sh
    bundle install
    ```

3. Configurar la base de datos:
    ```sh
    bin/rails db:setup
    ```

4. Iniciar el servidor:
    ```sh
    bin/rails server
    ```

## Búsqueda y filtros
Para la búsqueda y filtrado de productos se utilizó la gema `ransack`. Elegí esta gema porque permite la construcción de consultas complejas sin necesidad de escribir SQL manualmente, favoreciendo la legibilidad y la mantenibilidad del código.

## Permisos y autorización
Para manejar los permisos y la autorización de los usuarios, se utilizó la gema `cancancan`. Esta gema permite definir qué acciones puede realizar cada rol de usuario en la aplicación. Es una buena opción para este proyecto porque facilita la gestión de permisos de manera clara y sencilla, asegurando que solo los usuarios autorizados puedan realizar ciertas acciones.

## Sesiones
`Devise` es una gema de Ruby que facilita el manejo de sesiones y roles de usuario en una aplicación. La elegí porque simplifica la autenticación, proporciona muchas funcionalidades listas para usar y es fácil de configurar.

## Usuarios

### Roles de Usuario
Los usuarios pueden estar registrados o no en el sistema. Existen tres tipos de roles representados con un número y un enum: administrador (0), supervisor (1) y empleado (2). El rol por defecto es empleado.

### Bloqueo de Usuarios
Si el administrador decide bloquear a un usuario, la contraseña del mismo se cambiará por una aleatoria y el usuario no podrá iniciar sesión. Si desea desbloquearlo también puede hacerlo seleccionando la opción de "Desbloquear", generando una contraseña "password" con la que el usuario podrá volver a iniciar sesión.

### Registro y Autenticación
El registro y autenticación se hizo con la gema `Devise`. Los usuarios pueden registrarse con un correo electrónico y contraseña. Una vez registrados, pueden iniciar sesión utilizando sus credenciales. El sistema verifica las credenciales y, si son correctas, permite el acceso al usuario según su rol asignado.

### Gestión de Usuarios
Los administradores pueden gestionar los usuarios del sistema, incluyendo la creación, edición y eliminación de usuarios. También pueden asignar y cambiar roles de usuario según sea necesario.

## Productos
La sección de productos en tu aplicación permite a los usuarios ver, crear, editar y eliminar productos. Aquí hay una breve explicación de los puntos más importantes:

### Modelo de Producto (product.rb)
- Define las validaciones para los productos, como la presencia de nombre, descripción, precio y stock.
- Asegura que cada producto tenga al menos una imagen y que las imágenes sean de tipos y tamaños aceptables.
- Usa `ActiveStorage` para gestionar las imágenes adjuntas.

### Visualización de Productos (index.html.erb)
- Permite filtrar productos por nombre y categoría usando la gema `ransack`.
- Si un producto no tiene stock no se muestra para los usuarios NO administradores. Para el administrador se muestra un mensaje de "Sin stock".
- Los usuarios con permisos pueden ver un botón para agregar nuevos productos.

### Creación de Productos (new.html.erb)
- Permite agregar hasta 5 imágenes por producto.

## Ventas
La sección de ventas en tu aplicación permite a los usuarios con los permisos necesarios gestionar las ventas realizadas. Puntos importantes a tener en cuenta:

### Modelo de Ventas (sale.rb)
- La venta pertenece a un cliente.
- La venta tiene muchos ítems de venta, donde cada ítem contiene un producto.

### Creación de Ventas (new.html.erb)
- El cliente puede existir o no en el sistema. En caso de que exista, sobreescribe los datos de contacto, y en caso contrario lo agrega al sistema.

### Edición de Ventas (edit.html.erb)
- El DNI no se puede editar.

