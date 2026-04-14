package model;

public class Rutina {

    private int idRutina;
    private String nombre;
    private String objetivo;
    private String nivel;
    private int duracion;
    private String descripcion;

    public Rutina() {
    }

    public Rutina(int idRutina, String nombre, String objetivo, String nivel, int duracion, String descripcion) {
        this.idRutina = idRutina;
        this.nombre = nombre;
        this.objetivo = objetivo;
        this.nivel = nivel;
        this.duracion = duracion;
        this.descripcion = descripcion;
    }

    public int getIdRutina() {
        return idRutina;
    }

    public void setIdRutina(int idRutina) {
        this.idRutina = idRutina;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getObjetivo() {
        return objetivo;
    }

    public void setObjetivo(String objetivo) {
        this.objetivo = objetivo;
    }

    public String getNivel() {
        return nivel;
    }

    public void setNivel(String nivel) {
        this.nivel = nivel;
    }

    public int getDuracion() {
        return duracion;
    }

    public void setDuracion(int duracion) {
        this.duracion = duracion;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
}
