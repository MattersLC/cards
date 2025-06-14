# credit_cards_app

Una aplicación Flutter para gestionar tarjetas de crédito.

## Descripción

La aplicación permite a los usuarios agregar, editar, visualizar y eliminar tarjetas de crédito. Utiliza el patrón Bloc para la gestión del estado, asegurando una arquitectura escalable y fácil de mantener. Además, incluye validaciones en los formularios y una interfaz interactiva para mostrar las tarjetas de crédito con animaciones y efectos visuales.

## Características principales

1. **Gestión de tarjetas de crédito**:
   - Agregar nuevas tarjetas.
   - Editar tarjetas existentes.
   - Eliminar tarjetas.
   - Visualizar detalles de las tarjetas.

2. **Arquitectura basada en Bloc y Clean Architecture**:
   - El estado de las tarjetas se gestiona mediante `CardsBloc`, que permite manejar eventos como agregar, actualizar y eliminar tarjetas.
   - Las pantallas (`cards_page.dart`, `card_viewer_page.dart`, `edit_card_page.dart`) escuchan los cambios en el estado del Bloc para actualizar automáticamente la interfaz.

3. **Validaciones de formularios**:
   - Los formularios incluyen validaciones para campos como número de tarjeta, fecha de expiración, CVV, nombre del propietario y se agregó un campo adicional "alias" para personalizar aún más la experiencia del usuario.

4. **Interfaz interactiva**:
   - Uso del widget `CreditCardWidget` para mostrar tarjetas con efectos visuales como Glassmorphism y gradientes.
   - Animaciones suaves al interactuar con las tarjetas.
   - Diseños modernos en las tarjetas agregadas por el usuario.

5. **Persistencia de datos**:
   - Los datos de las tarjetas se almacenan en una base de datos local usando `SQFLite` asegurando la integridad de la información recabada.
   - Al implementar una capa de datos (data layer), se usó una fuente dedicada al obtención de información de manera local, sin embargo, esta arquitectura nos permite facilmente hacer la implementación de nuevas fuentes de datos, como puede ser un servidor privado a través de servicios API REST, GraphQL, etc.

## Estructura del proyecto

- **lib/features/cards**:
  - `presentation`: Contiene las pantallas y widgets relacionados con la interfaz de usuario.
  - `bloc`: Contiene la lógica de estado y eventos para gestionar las tarjetas.
  - `models`: Define los modelos de datos para las tarjetas de crédito.
  - `repository`: Implementa la lógica para interactuar con la base de datos o backend.

- **lib/widgets**:
  - Widgets reutilizables como `CreditCardWidget` y `CreditCardForm`.

El uso de `Clean Architecture` nos permite separar y desacoplar las funcionalidades de nuestra app, todo bajo la carpeta de `features`, si es necesario implementar una nueva funcionalidad de autenticación, o para guardar contactos además de las tarjetas de crédito, sólo necesitaremos crear la nueva carpeta de funcionalidad y empezar a desarrollar sobre sus propias capas de datos, dominio y presentación, volviendo el proyecto escalable y optimizando el tiempo de desarrollo.

## Cómo probar la aplicación

### Requisitos previos
1. Instalar Flutter en tu máquina. [Guía de instalación](https://docs.flutter.dev/get-started/install).
2. Asegúrate de tener un emulador o dispositivo físico conectado.

### Pasos para probar
1. **Clonar el repositorio**:

    ```bash
    git clone https://github.com/tu-usuario/credit_cards_app.git
    ```
2. **Dirigirte al proyecto y descargar las dependencias**:
    ```bash
    cd credit_cards_app
    flutter pub get
    ```
3. **Correr el proyecto**:
    ```bash
    flutter run
    ```
