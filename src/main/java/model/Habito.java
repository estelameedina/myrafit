package model;

import java.sql.Date;

public class Habito {

    private int idHabito;
    private int idUsuario;
    private Date fecha;
    private double horasSueno;
    private int pasos;
    private double agua;
    private int energia;

    public int getIdHabito() { return idHabito; }
    public void setIdHabito(int idHabito) { this.idHabito = idHabito; }

    public int getIdUsuario() { return idUsuario; }
    public void setIdUsuario(int idUsuario) { this.idUsuario = idUsuario; }

    public Date getFecha() { return fecha; }
    public void setFecha(Date fecha) { this.fecha = fecha; }

    public double getHorasSueno() { return horasSueno; }
    public void setHorasSueno(double horasSueno) { this.horasSueno = horasSueno; }

    public int getPasos() { return pasos; }
    public void setPasos(int pasos) { this.pasos = pasos; }

    public double getAgua() { return agua; }
    public void setAgua(double agua) { this.agua = agua; }

    public int getEnergia() { return energia; }
    public void setEnergia(int energia) { this.energia = energia; }
}