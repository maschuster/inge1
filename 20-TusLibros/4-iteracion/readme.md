# TusLibros - Iteración 4

## Instrucciones de uso

Para poder levantar el servidor se utiliza.

```
TusLibrosServerServices listeningOn: 8080.
```

Para abrir la ventana correspondiente al ingreso al servidor y creación de carrito se utiliza.

```
TusLibrosClientCreateCartWindow open.
```

En caso de querer verificar las instancias que se encuentran activas en el sistema y/o destruirlas.

```
TusLibrosServerServices allInstances.

TusLibrosServerServices allInstancesDo: [ :instance | instance destroy ].
```

## Credenciales

Las credenciales válidas para ingresar al sistema son `username: user` y `password: pass`. Cualquier otra combinación de credenciales resultará en un error de login.

## Catálogo y compra

El catálogo cuenta con dos libros disponibles La Biblia y La Torah. Ambos con sus respectivos ISBN provistos por la _factory_ de test. Para comprar un producto se debe seleccionar en la lista del catálogo (**Catalog**) el item correspondiente e introducir debajo la cantidad de elementos que deseamos comprar. Una vez realizado esto, presionar el botón **Add**.

El producto agregado debería aparecer en la lista de carrito (**Cart**), indicando el ISBN y la cantidad seleccionada entre paréntesis.

Para remover un libro del carrito se lo debe seleccionar en la lista del carrito e ingresar la cantidad de unidades que desean removerse. En caso de ingresar una cantidad mayor a la que posee el carrito, se obtendrá un error.

Para finalizar la compra y pagar, se presiona el botón de **Checkout** que nos llevará al detalle de la compra en formato de ticket. Allí se nos permitirá salir de la plataforma (**Logout**) o continuar comprando (**Create new cart**).

Recordar que cada carrito creado se inhabilitará luego de 30 minutos sin ser utilizado, por lo que al intentar realizar alguna acción (agregar, remover, pagar) arreojará el error correspondiente.

Por otro lado, en la ventana de catálogo se nos permite acceder al registro de nuestras compras (**Record**). Allí se nos dará un detalle de los productos que compramos, qué cantidad de cada uno entre paréntesis, el total gastado en ese producto y al final de todo el total gastado en la página hasta el momento.

## Salir

Para salir del servidor basta con cerrar las ventanas que tengamos abiertas.