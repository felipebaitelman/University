class StressSurvey < ApplicationRecord

  def calculate_result(params)
    # Beginning of result calculation
    a = parse_parms(params)
    final_sum = 0
    a.each {|val|
      final_sum += val.to_i
    }
    results = Array.new

    @current = User.find(self.user_id)

    if @current.academic_type.eql?('Alumno')
      case final_sum
        when 0..4
          results[0] = 'No se aprecia ansiedad'
          results[1] = 'Estimado alumno(a), ¡No necesitas preocuparte!'
        when 5..9
          results[0] = 'Se aprecian síntomas de ansiedad leves'
          results[1] = 'Estimado alumno(a), tus resultados indican que tienes pocos o ningún síntoma de ansiedad. Si bien eso puede ser beneficioso para ti, debes entender que la ansiedad es una emoción que te permite activarte, y que presentar bajos niveles puede generar conductas pasivas y falta de motivación. Si tienes dudas acerca de tu resultado o acerca de la ansiedad, escríbenos a ansiedad@uc.cl.'
        when 10..14
          results[0] = 'Se aprecian síntomas de ansiedad moderados'
          results[1] = 'Estimado alumno(a), tus resultados indican que presentas síntomas moderados de ansiedad. Según tus respuestas, estos síntomas pueden estar afectando tu diario vivir y generándote dificultades en una o más áreas de tu vida.  Te recomendamos hablar con un profesional para ver qué puedes hacer para que tus síntomas disminuyan. Es importante que sepas que presentar síntomas moderados de ansiedad no equivale a tener un trastorno de ansiedad. Puedes solicitar una consejería individual de ansiedad o participar de los talleres \'Manejando mi ansiedad\' a cargo de un psicólogo perteneciente al Programa para el Manejo de la Ansiedad y el buen dormir. Para mayor información, escríbenos a ansiedad@uc.cl'
        when 15..21
          results[0] = 'Se aprecian síntomas de ansiedad severos'
          results[1] = 'Estimado alumno(a), tus resultados indican que estás teniendo sintomatología severa de ansiedad. Tus respuestas señalan que durante las últimas semanas, la ansiedad ha logrado interferir en gran medida en tu diario vivir. Te recomendamos consultar en la Unidad de Apoyo Psicológico ubicada en el 3er piso del Hall Universitario del campus San Joaquín para solicitar una hora con un profesional que te puede orientar con lo que estás sintiendo. Presentar síntomas severos de ansiedad no equivale a tener un trastorno de ansiedad. Para mayor información, puedes escribirnos a ansiedad@uc.cl o visitar el sitio http://apoyo.saludestudiantil.uc.cl'
      end
    elsif @current.academic_type.eql? ('Funcionario')
      case final_sum
        when 0..4
          results[0] = 'No se aprecia ansiedad'
          results[1] = 'Estimado funcionario(a), ¡No necesitas preocuparte!'
        when 5..9
          results[0] = 'Se aprecian síntomas de ansiedad leves'
          results[1] = 'Estimado funcionario(a), tus resultados indican que tienes pocos o ningún síntoma de ansiedad. Si bien eso puede ser beneficioso para ti, debes entender que la ansiedad es una emoción que te permite activarte, y que presentar bajos niveles puede generar conductas pasivas y falta de motivación. Si tienes dudas acerca de tu resultado o acerca de la ansiedad, escríbenos a ansiedad@uc.cl.'
        when 10..14
          results[0] = 'Se aprecian síntomas de ansiedad moderados'
          results[1] = 'Estimado funcionario(a), tus resultados indican que presentas síntomas moderados de ansiedad. Según tus respuestas, estos síntomas pueden estar afectando tu diario vivir y generándote dificultades en una o más áreas de tu vida.  Te recomendamos hablar con un profesional para ver qué puedes hacer para que tus síntomas disminuyan. Es importante que sepas que presentar síntomas moderados de ansiedad no equivale a tener un trastorno de ansiedad. Para mayor información, escríbenos a ansiedad@uc.cl.'
        when 15..21
          results[0] = 'Se aprecian síntomas de ansiedad severos'
          results[1] = 'Estimado funcionario(a), tus resultados indican que estás teniendo sintomatología severa de ansiedad. Tus respuestas señalan que durante las últimas semanas, la ansiedad ha logrado interferir en gran medida en tu diario vivir. Te recomendamos consultar a un profesional que te pueda orientar con lo que estás sintiendo. Presentar síntomas severos de ansiedad no equivale a tener un trastorno de ansiedad. Para mayor información, puedes escribirnos a ansiedad@uc.cl.'
      end
    end

    results[2]=final_sum

    results
  end



  def parse_parms(params)
    a = Array.new(0)
    a[0] = params[:p1]
    a[1] = params[:p2]
    a[2] = params[:p3]
    a[3] = params[:p4]
    a[4] = params[:p5]
    a
  end
end
