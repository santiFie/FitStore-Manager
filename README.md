# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Versión de Ruby
    3.2.6

* Dependencias del sistema
    Las puede conocer ejecutando el comandoi `bundle list`

* Creación e Inicialización de la base de datos

    Para inicializar la base de datos, se debe ejecutar el comando `bin/rails db:setup`. Este comando creará la base de datos, ejecutará las migraciones y cargará los datos iniciales definidos en el archivo `seeds.rb`.

    El archivo `seeds.rb` se encarga de asegurar la existencia de los registros necesarios para que la aplicación funcione correctamente.



* Servicios 
    Para la búsqueda y filtrado de productos se uso la gema ransack. Para mas información visitar [Documentación](https://github.com/activerecord-hackery/ransack)

* Instrucciones de despliegue


    1. Clonar el repositorio:
        ```sh
        git clone 
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

    

* **Usuarios**

    **Roles de Usuario**

    Los usuarios pueden estar registrados o logueados en el sistema. Existen tres tipos de roles representados con un número y un enum: administrador (0), supervisor (1) y empleado (2). El rol por defecto es empleado.


    **Bloqueo de Usuarios**

    Si el administrador decide bloquear a un usuario, la contraseña del mismo se cambiará por una aleatoria y el usuario no podrá iniciar sesión. Si desea desbloquearlo también puede hacerlo seleccionando la opción de "Desbloquear", generando una contraseña "password" con la que el usuario podrá volver a iniciar sesión.

    **Registro y Autenticación**

    El registro y autenticación se hizo con la gema Devise. Los usuarios pueden registrarse con un correo electrónico y contraseña. Una vez registrados, pueden iniciar sesión utilizando sus credenciales. El sistema verifica las credenciales y, si son correctas, permite el acceso al usuario según su rol asignado.

    **Gestión de Usuarios**

    Los administradores pueden gestionar los usuarios del sistema, incluyendo la creación, edición y eliminación de usuarios. También pueden asignar y cambiar roles de usuario según sea necesario.

**Productos**

    La sección de productos en tu aplicación permite a los usuarios ver, crear, editar y eliminar productos. Aquí hay un resumen de cómo funciona cada parte:

    Visualización de Productos (index.html.erb):

    Muestra una lista de productos.
    Permite filtrar productos por nombre y categoría usando la gema ransack.
    Los productos se muestran con su nombre, imagen, descripción y precio.
    Si un producto no tiene stock, se muestra un mensaje de "Sin stock".
    Los usuarios con permisos pueden ver un botón para agregar nuevos productos.

    Creación de Productos (new.html.erb):

    Formulario para crear un nuevo producto.
    Incluye campos para nombre, descripción, precio, stock disponible, categoría e imágenes.
    Permite agregar hasta 5 imágenes por producto.
    Muestra mensajes de éxito o error según corresponda.

    Edición de Productos (edit.html.erb):

    Formulario para editar un producto existente.
    Similar al formulario de creación, pero también permite eliminar imágenes existentes.
    Muestra mensajes de éxito o error según corresponda.

    Controlador de Productos (products_controller.rb):

    Gestiona las acciones de crear, leer, actualizar y eliminar productos.
    Usa la gema cancancan para autorizar acciones según los permisos del usuario.
    Maneja la lógica para agregar y eliminar imágenes de productos.

    Modelo de Producto (product.rb):

    Define las validaciones para los productos, como la presencia de nombre, descripción, precio y stock.
    Asegura que cada producto tenga al menos una imagen y que las imágenes sean de tipos y tamaños aceptables.
    Usa ActiveStorage para gestionar las imágenes adjuntas.
    Permite buscar productos por ciertos atributos usando ransack.

**Ventas**

    La sección de ventas en tu aplicación permite a los usuarios gestionar las ventas realizadas. Aquí hay un resumen de cómo funciona cada parte:

    Visualización de Ventas (index.html.erb):

    - Muestra una lista de ventas.
    - Permite ver detalles de cada venta, incluyendo el cliente y el total de la venta.
    - Los usuarios con permisos pueden editar o cancelar ventas.

    Creación de Ventas (new.html.erb):

    - Formulario para crear una nueva venta.
    - Incluye campos para seleccionar el cliente, agregar productos y cantidades.
    - Calcula automáticamente el subtotal y el total de la venta.
    - Muestra mensajes de éxito o error según corresponda.

    Edición de Ventas (edit.html.erb):

    - Formulario para editar una venta existente.
    - Similar al formulario de creación, pero también permite eliminar productos de la venta.
    - Muestra mensajes de éxito o error según corresponda.

    Controlador de Ventas (sales_controller.rb):

    - Gestiona las acciones de crear, leer, actualizar y cancelar ventas.
    - Usa la gema cancancan para autorizar acciones según los permisos del usuario.
    - Maneja la lógica para calcular subtotales y totales de las ventas.

    Modelo de Venta (sale.rb):

    - Define las validaciones para las ventas, como la presencia de fecha y total.
    - Asegura que cada venta tenga al menos un producto y que haya suficiente stock disponible.
    - Permite agregar y eliminar productos de una venta.

    Modelo de Item de Venta (sale_item.rb):

    - Define las validaciones para los items de venta, como la presencia de cantidad.
    - Calcula automáticamente el subtotal de cada item de venta.
    - Actualiza el stock disponible del producto al crear o eliminar un item de venta.

