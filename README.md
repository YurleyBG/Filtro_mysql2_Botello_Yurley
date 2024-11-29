# El Universitario

es una base de dato encargada de mantener el registros de una universidad como lo son los alumnos, profesores,matriculas,grados,departamentos ,cursos escolares  y asignatura.
donde se piden ciertos requerimientos que se deben cumplir en la misma para cumplir estos se han implementado consultas , funciones, triggers y eventos.

# Tecnologias utilizadas

se han utilizdo tecnologias como :

*  Mysql workbeach

# Como se usa 

 Deberas clonar el repositorio  a través de github bash   con el siguiente link

 https://github.com/YurleyBG/Filtro_mysql2_Botello_Yurley.git


 depues de clonado deberas abrir mysql workbeach y  ejecutar cada unas de las carpetas en el mismo para ver como funciona.

 # Estruturas de los archivos
 
*  ddl.sql (Creación de base de datos con tablas y relaciones)
* dml.sql (inserciones de datos)
* dql_select.sql (Consultas)
* dql_funciones.sql (funciones)
* dql_triggers.sql (triggers)
* dql_eventos.sql (eventos)
* Readme.md
* Diagrama.png (Modelo de datos)

  # Consultas
  
  ```sql
   use universitario_t2;
 
  -- Consultas SQL
  
  -- 1 Encuentra el profesor que ha impartido más asignaturas en el último año académico.
  
   select p.nombre,count(a.id_profesor) as cantidad  from profesor p left join asignatura a on p.id=a.id_profesor
   inner join alumno_se_matricula_asignatura am on a.id =am.id_asignatura  where am.id_curso_escolar=4 group by 1;
  
  -- 2 Lista los cinco departamentos con mayor cantidad de asignaturas asignadas.
  
  select d.nombre, count(*) as asignatura_asignada from departamento d inner join profesor p on d.id = p.id_departamento inner join asignatura a on
  a.id_profesor =p.id group by 1 limit 5;
  -- 3 Obtén el total de alumnos y docentes por departamento.
  
  select d.nombre,(p.id_departamento) as cantidad_profesor, count(am.id_alumno) as cantidad_alumno from departamento d 
  inner join profesor p on d.id = p.id_departamento inner join asignatura a on p.id = a.id 
  inner join  alumno_se_matricula_asignatura  am on a.id = am.id_asignatura  inner join alumno on alumno.id =am.id_alumno group by 1,2;
  
  -- 4 Calcula el número total de alumnos matriculados en asignaturas de un género específico en un semestre determinado.
  select d.nombre, count(am.id_alumno) as cantidad_alumno from departamento d 
  inner join profesor p on d.id = p.id_departamento inner join asignatura a on p.id = a.id 
  inner join  alumno_se_matricula_asignatura  am on a.id = am.id_asignatura  inner join alumno on alumno.id =am.id_alumno where d.nombre='informatica' and a.cuatrimestre=1 group by 1;
  -- 5 Encuentra los alumnos que han cursado todas las asignaturas de un grado específico.
  select alumno.nombre,  alumno.apellido1, g.id from departamento d 
  inner join profesor p on d.id = p.id_departamento inner join asignatura a on p.id = a.id 
  inner join  alumno_se_matricula_asignatura  am on a.id = am.id_asignatura  
  inner join alumno on alumno.id =am.id_alumno inner join grado g on a.id_grado=g.id where g.id=4 and a.curso=3 group by 1,2,3;
  
  -- 6 Lista los tres grados con mayor número de asignaturas cursadas en el último semestre.
  select g.nombre, count(a.id_grado) as numero_asignaturas from asignatura a
  inner join grado g on a.id_grado=g.id where a.cuatrimestre=2  group by 1;
  -- 7 Muestra los cinco profesores con menos asignaturas impartidas en el último año académico.
  
  select p.nombre, count(a.id_profesor) from  profesor p 
  left join asignatura a on p.id = a.id_profesor 
  inner join alumno_se_matricula_asignatura am on a.id =am.id_asignatura where am.id_curso_escolar=4  group by 1;
  
  -- 8 Calcula el promedio de edad de los alumnos al momento de su primera matrícula.
  select avg (edad) from (select 2024 - year(fecha_nacimiento) as edad from alumno )as obtener;
  
  
  -- 9 Encuentra los cinco profesores que han impartido más clases de un mismo grado.
  
  select p.nombre, count(a.id_grado) from profesor p inner join asignatura a on a.id_profesor=p.id group by 1;
  
  -- 10 Genera un informe con los alumnos que han cursado más de 10 asignaturas en el último año.
  select alumno.nombre , count(am.id_asignatura) as 'cantidad' from alumno inner join alumno_se_matricula_asignatura am 
  on am.id_alumno=alumno.id group by 1 having cantidad>10 ;
  -- 11 Calcula el promedio de créditos de las asignaturas por grado.
  
  select grado, avg(cantidad_credito) as credito from (select g.nombre as 'grado', count(a.creditos) as 'cantidad_credito' from asignatura a 
  inner join grado g on a.id_grado=g.id group by 1 )as obtener group by 1;
  
  -- 12 Lista las cinco asignaturas más largas (en horas) impartidas en el último semestre.
  
  -- no hay una  tabla con una columna que indique las horas
  
  -- 13 Muestra los alumnos que han cursado más asignaturas de un género específico.
  select alumno.nombre, alumno.apellido1, alumno.apellido2 , count(am.id_asignatura)as cantidad_asignaturas from alumno 
  inner join alumno_se_matricula_asignatura am   on alumno.id =am.id_alumno inner join asignatura a on a.id=am.id_asignatura
  where a.tipo='basica' group by 1,2,3;
  
  -- 14 Encuentra la cantidad total de horas cursadas por cada alumno en el último semestre.
  
  -- no hay una  tabla con una columna que indique las horas
  
  -- 15 Muestra el número de asignaturas impartidas diariamente en cada mes del último trimestre.
  
  -- no hay fecha  del mes  en el que se impartieron las asignaturas para calcular
  
  -- 16 Calcula el total de asignaturas impartidas por cada profesor en el último semestre.
  
  select p.nombre, p.apellido1, p.apellido2 , count(a.id_profesor)as cantidad_asignaturas from profesor p inner join asignatura a  on p.id =a.id_profesor
  where a.cuatrimestre=2 group by 1,2,3; 
  
  -- 17 Encuentra al alumno con la matrícula más reciente.
  
  -- no hay fecha de registro de la matricula de los alumnos
  
  -- 18 Lista los cinco grados con mayor número de alumnos matriculados durante los últimos tres meses.
  -- 19 Obtén la cantidad de asignaturas cursadas por cada alumno en el último semestre.
  select alumno.nombre, alumno.apellido1, alumno.apellido2 , count(am.id_asignatura)as cantidad_asignaturas from alumno 
  inner join alumno_se_matricula_asignatura am   on alumno.id =am.id_alumno inner join asignatura a on a.id=am.id_asignatura
  where a.cuatrimestre=2 group by 1,2,3; 
  
  -- 20 lista los profesores que no han impartido clases en el último año académico.
  
   select p.nombre from profesor p inner join asignatura a on p.id=a.id_profesor
  inner join  alumno_se_matricula_asignatura am on a.id =am.id_asignatura  where am.id_curso_escolar=4 group by 1;
  ```

 # Funciones
    ```sql
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
    
    ```
  # Creditos

  Este proyecto filtro fue desarrollado por Yurley Botello Garcia para mysql 2;
  
