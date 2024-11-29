 use universitario_t2;
-- 1 TotalCreditosAlumno(AlumnoID, Anio): Calcula el total de créditos cursados por un alumno en un año específico.

delimiter //
create function TotalCreditosAlumno(AlumnoID int , Anio varchar(15))
returns int deterministic
begin
 declare total int;
 set total=(select count(a.creditos) from asignatura a inner join alumno_se_matricula_asignatura am on am.id_asignatura=a.id inner join curso_escolar c on am.id_curso_escolar=c.id
 where am.id_alumno=AlumnoID and  c.anyo_inicio=anio  or c.anyo_fin=anio);
 return total;
end //
delimiter ;

select TotalCreditosAlumno(1,'2017') as total_credito;
-- 2 PromedioHorasPorAsignatura(AsignaturaID): Retorna el promedio de horas de clases para una asignatura.
delimiter //
create function PromedioHorasPorAsignatura(AsignaturaID int)
returns int deterministic
begin

end //
delimiter ;




-- 3 TotalHorasPorDepartamento(DepartamentoID): Calcula la cantidad total de horas impartidas por un departamento específico.
-- 
-- 4 VerificarAlumnoActivo(AlumnoID): Verifica si un alumno está activo en el semestre actual basándose en su matrícula.
-- se enviara un mensaje que indique el estado del alumno
delimiter //
create function VerificarAlumnoActivo(AlumnoID int)
returns int deterministic
begin
 declare activo int;
 set activo= (select count(am.id_alumno) from alumno_se_matricula_asignatura am inner join asignatura a on am.id_asignatura=a.id inner join alumno on am.id_alumno=alumno.id where am.id_alumno=AlumnoID and a.cuatrimestre=2 );
 if activo >1 then
	signal sqlstate '45000'  set message_text ="este estudiante esta activo";
else 
	if activo=0 then
		signal sqlstate '45000'  set message_text ="este estudiante esta inactivo";
	end if;
 end if;
 return activo;
end //
delimiter ;
select VerificarAlumnoActivo(1);
-- 5EsProfesorVIP(ProfesorID): Verifica si un profesor es "VIP" basándose en el número de asignaturas impartidas y evaluaciones de desempeño.