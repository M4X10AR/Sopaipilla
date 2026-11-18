/**
 * script.js
 * 1. pide los datos y regresa los objetos desde el backend (JSON)
 * 2. busca imagenes de los objetos en la pagina mario wiki
 * 3. muestra la tabla y aplica los filtros en el navegador.
 */
const URL_API = "http://localhost:3000/api/objetos";
const URL_WIKI = "https://www.mariowiki.com/api.php?action=query&format=json"
    + "&origin=*&redirects=1&prop=pageimages&pithumbsize=80";

// imagen de respaldo (en caso de que no haya imagen)
const SIN_IMAGEN = "data:image/svg+xml;utf8,"
    + encodeURIComponent('<svg xmlns="http://www.w3.org/2000/svg" width="80" height="80">'
    + '<rect width="80" height="80" fill="#e9ecef"/>'
    + '<text x="40" y="52" font-size="36" text-anchor="middle" fill="#6c757d">?</text></svg>');

// referencias al DOM
const inputNombre = document.getElementById("buscarNombre");
const selectHabilidad = document.getElementById("filtroCategoria");
const botonLimpiar = document.getElementById("limpiarFiltros");
const mensaje = document.getElementById("mensaje");
const tabla = document.getElementById("tablaObjetos");

let objetos = [];     // datos recibidos del backend
let imagenes = {};    // nombre_en -> URL de la imagen

// evita que texto de la base se interprete como HTML
function escapar(texto) {
    const div = document.createElement("div");
    div.textContent = texto ?? "";
    return div.innerHTML;
}

// pide todas las imágenes de los objetos
async function cargarImagenes() {
  // Nombres en inglés, sin repetir y sin vacíos
    const titulos = [...new Set(objetos.map(o => o.nombre_en).filter(Boolean))];
    if (titulos.length === 0) return;

    try {
    const respuesta = await fetch(URL_WIKI + "&titles=" + encodeURIComponent(titulos.join("|")));
    const consulta = (await respuesta.json()).query;

    // La wiki puede normalizar o redirigir títulos: se guardan esos cambios
    const normalizados = {};
    (consulta.normalized || []).forEach(n => { normalizados[n.from] = n.to; });

    const redirigidos = {};
    (consulta.redirects || []).forEach(r => { redirigidos[r.from] = r.to; });

    // Título final de la página -> URL de la miniatura
    const porTitulo = {};
    Object.values(consulta.pages).forEach(p => {
        if (p.thumbnail) porTitulo[p.title] = p.thumbnail.source;
    });

    // Para cada objeto: título -> normalizado -> redirigido -> imagen
    titulos.forEach(t => {
        let final = normalizados[t] || t;
        final = redirigidos[final] || final;
        if (porTitulo[final]) imagenes[t] = porTitulo[final];
    });
    } catch (error) {
    console.warn("No se pudieron cargar las imágenes:", error);
    }
}

// llena el <select> con las habilidades sin repetir
function llenarHabilidades() {
    const habilidades = [...new Set(objetos.map(o => o.habilidad))].sort();
    habilidades.forEach(h => {
    const opcion = document.createElement("option");
    opcion.value = h;
    opcion.textContent = h;
    selectHabilidad.appendChild(opcion);
    });
}

// dibuja las filas de la tabla
function mostrarTabla(lista) {
    tabla.innerHTML = lista.map(o => `
    <tr>
        <td><img src="${escapar(imagenes[o.nombre_en] || SIN_IMAGEN)}"
                alt="${escapar(o.Name_Objeto)}" width="48" height="48"
                style="object-fit:contain"></td>
        <td>${escapar(o.Name_Objeto)}</td>
        <td>${escapar(o.descripcion)}</td>
        <td>${escapar(o.habilidad)}</td>
        <td>${o.Key_Objeto ? "Clave" : "Normal"}</td>
    </tr>`).join("");

    mensaje.textContent = lista.length === 0
    ? "No hay objetos que coincidan con los filtros."
    : `Mostrando ${lista.length} de ${objetos.length} objetos.`;
}

// combina búsqueda por nombre y filtro por habilidad de pedirlo a la base de datos
function aplicarFiltros() {
    const texto = inputNombre.value.trim().toLowerCase();
    const habilidad = selectHabilidad.value;

    const filtrados = objetos.filter(o =>
    o.Name_Objeto.toLowerCase().includes(texto) &&
    (habilidad === "" || o.habilidad === habilidad)
    );
    mostrarTabla(filtrados);
}

function limpiarFiltros() {
    inputNombre.value = "";
    selectHabilidad.value = "";
    mostrarTabla(objetos);
}

// Carga inicial
async function iniciar() {
    try {
    const respuesta = await fetch(URL_API);
    if (!respuesta.ok) throw new Error("Error " + respuesta.status);
    objetos = await respuesta.json();

    llenarHabilidades();
    await cargarImagenes();   // si falla, igual se muestra la tabla
    mostrarTabla(objetos);
    } catch (error) {
    mensaje.textContent = "No se pudo conectar con el backend. ¿Está corriendo npm run dev?";
    console.error(error);
    }
}

inputNombre.addEventListener("input", aplicarFiltros);
selectHabilidad.addEventListener("change", aplicarFiltros);
botonLimpiar.addEventListener("click", limpiarFiltros);

iniciar();