package model;

import java.sql.Date;

public class CicloMenstrual {

    private int idCiclo;
    private int idUsuario;
    private Date fecha;
    private String fase;
    private String notas;

    public CicloMenstrual() {
    }

    public CicloMenstrual(int idCiclo, int idUsuario, Date fecha, String fase, String notas) {
        this.idCiclo = idCiclo;
        this.idUsuario = idUsuario;
        this.fecha = fecha;
        this.fase = fase;
        this.notas = notas;
    }

    public int getIdCiclo() {
        return idCiclo;
    }

    public void setIdCiclo(int idCiclo) {
        this.idCiclo = idCiclo;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getFase() {
        return fase;
    }

    public void setFase(String fase) {
        this.fase = fase;
    }

    public String getNotas() {
        return notas;
    }

    public void setNotas(String notas) {
        this.notas = notas;
    }
}