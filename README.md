# Inventario de objetos de Paper Mario

Página web que muestra los objetos de *Paper Mario: La Puerta Milenaria* que se encuentran en una base de datos MySQL. Se puede buscar un por su nombre y filtrar por su habilidad.

## Tecnologías Utilizadas
-MySQL (base de datos)
-Node.js + Express + mysql2 (para el backend)
-HTML, CSS, JavaScript y Bootstrap (para el frontend)

## Instalación y ejecución

### 1. Crear la base de datos
1.Abrir MySQL Workbench y conectarse al servidor local.
2.Abrir `backend/datos.sql` y ejecutarlo completo (ícono del rayo).
3.Comprobar que existe la base `inventario` con sus tablas.
### 2. Configurar el backend
1.Abrir una terminal dentro de la carpeta `backend`.

2.Instalar dependencias:

```npm install ```

3.Crear un archivo `.env` dentro de `backend` con este contenido
(reemplazar la contraseña por la de tu MySQL):
```
PORT=3000
DB_HOST=localhost
DB_PORT=3306
DB_DATABASE=Inventario
DB_USER=root
DB_PASSWORD=TU_CLAVE_MYSQL
FRONTEND_URL=http://127.0.0.1:5500
```
4.Iniciar el servidor:
```npm run dev```

Debe aparecer: `Servidor escuchando en el puerto 3000`.

5.Comprobar en el navegador: http://localhost:3000/api/objetos

### 3. Ejecutar el frontend

1.Abrir la carpeta `frontend` en Visual Studio Code.

2.Clic derecho en `index.html` → **Open with Live Server**.

3.Se abre http://127.0.0.1:5500 con la aplicación.

> Mantener el backend y Live Server encendidos mientras se usa la página.

## Uso
-**Buscar por nombre:** escribir en el cuadro de búsqueda.
-**Filtrar por habilidad:** elegir una opción de la lista.
-**Limpiar filtros:** botón para volver a ver todos los objetos.