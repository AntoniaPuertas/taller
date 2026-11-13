<?php
// Modelo: todo el SQL de las reparaciones está aquí, y solo aquí
class ReparacionModelo
{
    public function __construct(private PDO $pdo) {}

    // Todas las reparaciones, de la más reciente a la más antigua
    public function todas(): array
    {
        // TODO 1: devuelve todas las filas de una consulta que una reparaciones,
        //         vehiculos y mecanicos, con estas columnas: id, fecha_entrada,
        //         fecha_salida, descripcion, matricula, marca, modelo
        //         y el nombre del mecánico con el alias «mecanico»
        $sql = "select reparaciones.id, reparaciones.fecha_entrada, reparaciones.fecha_salida, reparaciones.descripcion, vehiculos.matricula, vehiculos.marca, vehiculos.modelo, mecanicos.nombre as mecanico
                FROM reparaciones, vehiculos, mecanicos
                WHERE reparaciones.vehiculo_id = vehiculos.id
                AND reparaciones.mecanico_id = mecanicos.id
                ORDER BY reparaciones.fecha_entrada DESC";

        $consulta = $this->pdo->query($sql);
        return $consulta->fetchAll();
    }
}