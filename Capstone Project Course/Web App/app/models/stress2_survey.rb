class Stress2Survey < ApplicationRecord

  def calculate_result(params)
    # Beginning of result calculation
    a = parse_results(params)
    final_sum = 0
    a.each {|val|
      final_sum += val.to_i
    }
    results = Array.new
    results[2]=final_sum

    @current = User.find(self.user_id)

    if @current.academic_type.eql?('Alumno')
      case final_sum
        when 0..18
          results[0] = 'Nivel leve de estrés percibido'
          results[1] = 'Estimado alumno(a), has podido afrontar y adaptarte a situaciones demandantes en el último mes. , Identifica lo que te ha ayudado hasta ahora para mantener niveles bajos de estrés y así poder seguir utilizando esos recursos cada vez que los necesites. Para que tu nivel no aumente, te recomendamos organizar tus tiempos acorde a tus demandas, priorizar tareas y equilibrar tu estilo de vida con actividades que posibiliten tu recreación y descanso. Existen diferentes actividades realizadas por nuestro programa que te pueden interesar, como lo son los talleres de Mindfulness, consejerías de ansiedad y talleres grupales “manejando mi ansiedad”. Recuerda que puedes solicitar tu hora online.'
        when 19..37
          results[0] = 'Nivel moderado de estrés percibido'
          results[1] = 'Estimado alumno(a), en el último mes,  puedes percibir que tu nivel de estrés se ha mantenido estable en el tiempo llevándote a sentir irritabilidad, cansancio, problemas para dormir, dolores de cabeza, entre otros. Es importante que puedas generar cambios para que tu nivel de percepción de estrés disminuya. Revisa las demandas que sean modificables y que estén bajo tu control, y asegúrate de complementar tus actividades con tiempo de descanso y recreación. Si sientes que esto se te dificulta, te recomendamos solicitar una hora de consejería de ansiedad o informarte de los servicios que ofrece la universidad.'
        when 38..56
          results[0] = 'Nivel alto de estrés percibido'
          results[1] = 'Estimado alumno(a), en el último mes la intensidad de tus síntomas ha logrado interferir en algunas áreas de tu vida.  Puedes estar mostrándote  irritable, estar teniendo insomnio, pesadillas, sintiendo tensión muscular, agotamiento, ansiedad, falta de concentración y atención, dificultades para pensar, además de una disminución en tus defensas inmunitarias. Mantenerte en este estado puede perjudicarte aún más si las condiciones de tu entorno no se modifican. Te recomendamos solicitar una opinión profesional dentro del corto plazo para evaluar tu situación. Acércate a la Unidad de Apoyo Psicológico ubicada en el 3er piso del Hall Universitario en campus San Joaquín o ingresa a http://apoyo.saludestudiantil.uc.cl/ para pedir una hora.'
      end
    elsif @current.academic_type.eql? ('Funcionario')
      case final_sum
        when 0..18
          results[0] = 'Nivel leve de estrés percibido'
          results[1] = 'Estimado funcionario(a), has podido afrontar y adaptarte a situaciones demandantes en el último mes. , Identifica lo que te ha ayudado hasta ahora para mantener niveles bajos de estrés y así poder seguir utilizando esos recursos cada vez que los necesites. Para que tu nivel no aumente, te recomendamos organizar tus tiempos acorde a las demandas, priorizar tareas y equilibrar tu estilo de vida con actividades que posibiliten tu recreación y descanso. Existen diferentes actividades realizadas por nuestro programa que te pueden interesar, como lo son los talleres de yoga para funcionarios ofrecidos de manera semanal.  Recuerda que puedes reservar tu cupo online. '
        when 19..37
          results[0] = 'Nivel moderado de estrés percibido'
          results[1] = 'Estimado funcionario(a), en el último mes,  puedes percibir que tu nivel de estrés se ha mantenido estable en el tiempo llevándote a sentir irritabilidad, cansancio, problemas para dormir, dolores de cabeza, entre otros. Es importante que puedas generar cambios para que tu nivel de percepción de estrés disminuya. Revisa las demandas que sean modificables y que estén bajo tu control, y asegúrate de complementar tus actividades con tiempo de descanso y recreación. Si tienes dudas en relación a este tema, contáctanos a ansiedad@uc.cl.'
        when 38..56
          results[0] = 'Nivel alto de estrés percibido'
          results[1] = 'Estimado funcionario(a), en el último mes la intensidad de tus síntomas ha logrado interferir en algunas áreas de tu vida.  Puedes estar mostrándote  irritable, estar teniendo insomnio, pesadillas, sintiendo tensión muscular, agotamiento, ansiedad, falta de concentración y atención, dificultades para pensar, además de una disminución en tus defensas inmunitarias. Mantenerte en este estado puede perjudicarte aún más si las condiciones de tu entorno no se modifican. Te recomendamos solicitar una opinión profesional dentro del corto plazo para evaluar tu situación. Si tienes alguna duda en relación a tu resultado, escríbenos a ansiedad@uc.cl.'
      end
    end


    results
  end

  def parse_results(params)
    a = Array.new(0)
    a[0] = params[:p1]
    a[1] = params[:p2]
    a[2] = params[:p3]
    a[3] = params[:p4]
    a[4] = params[:p5]
    a[5] = params[:p6]
    a[6] = params[:p7]
    a[7] = params[:p8]
    a[8] = params[:p9]
    a[9] = params[:p10]
    a[10] = params[:p11]
    a[11] = params[:p12]
    a[12] = params[:p13]
    a[13] = params[:p14]
    a
  end

end
