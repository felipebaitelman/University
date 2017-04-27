class SleepSurvey < ApplicationRecord

  def calculate_result(params)
    # Beginning of result calculation
    bad_condition = 0
    a = parse_params(params)

    if (a[0].to_f - a[1].to_f).abs > 1.5
      bad_condition += 1
    end
    if (a[2].eql? 'option1') ||  (a[2].eql? 'option2')
      bad_condition += 1
    end
    if a[3].eql? 'option3'
      bad_condition += 1
    end
    if (a[4].eql?'option4') || (a[4].eql?'option5')
      bad_condition += 1
    elsif a[4].eql?('option2') || a[5].equal?('option3')
      bad_condition += 1
    elsif a[4].eql?('option3') || a[5].equal?('option3')
      bad_condition += 1
    end
    if (a[6].eql? 'option1') ||  (a[6].eql? 'option2')
      (a[6].eql? 'option1') ||  (a[6].eql? 'option2')
    end

    if (a[7].eql? 'option1') || (a[8].eql? 'option1') || (a[9].eql? 'option1') || 
        (a[10].eql? 'option1') || (a[11].eql? 'option1')
      bad_condition += 1
    end
    results = Array.new
    results[2]=bad_condition

    @current = User.find(self.user_id)

    if @current.academic_type.eql?('Alumno')
      case
        when bad_condition >= 2
          results[0] = 'Calidad de sueño mala'
          results[1] = 'Estimado alumno(a), tu calidad de sueño se ha visto altamente interferida, implicando costos en una o más áreas de tu vida. Te recomendamos que puedas trabajar en estrategias que te posibiliten un buen dormir, solicitando una hora en las consejerías de sueño. Recuerda que puedes tomar tu hora online.'
        when bad_condition == 1
          results[0] = 'Calidad de sueño regular'
          results[1] = 'Estimado alumno(a), tu calidad de sueño se ha visto moderadamente interferida, por lo que te recomendamos algunas estrategias para favorecer el buen dormir, como  practicar ejercicios de relajación de RelaxUC, disminuir el consumo de sustancias activantes durante el día, bajar la luminosidad de tu entorno antes de dormir, anotar tus preocupaciones estando acostado, entre otras. Si necesitas mayor información puedes escribirnos a ansiedad@uc.cl'
        when bad_condition == 0
          results[0] = 'Calidad de sueño buena'
          results[1] = 'Estimado alumno(a), ¡Felicitaciones! Tu calidad de sueño no se ha visto interferida en el último tiempo, lo que te permite tener un sueño reparador. Identifica las estrategias que te estén favoreciendo tu buen dormir, para que puedas saber qué hacer a la hora de necesitarlo. Si te interesa saber más de este tema, escríbenos a ansiedad@uc.cl'
      end

    elsif @current.academic_type.eql? ('Funcionario')
      case
        when bad_condition >= 2
          results[0] = 'Calidad de sueño mala'
          results[1] = 'Estimado funcionario(a), tu calidad de sueño se ha visto altamente interferida, implicando costos en una o más áreas de tu vida. Te recomendamos puedas contactar a un profesional, para que puedas trabajar en estrategias que te posibiliten un buen dormir. Si necesitas mayor información, escríbenos a ansiedad@uc.cl.'
        when bad_condition == 1
          results[0] = 'Calidad de sueño regular'
          results[1] = 'Estimado funcionario(a), tu calidad de sueño se ha visto moderadamente interferida, por lo que te recomendamos algunas estrategias para favorecer el buen dormir, como  practicar ejercicios de relajación de RelaxUC, disminuir el consumo de sustancias activantes durante el día, bajar la luminosidad de tu entorno antes de dormir, anotar tus preocupaciones estando acostado, entre otras. Si necesitas mayor información puedes escribirnos a ansiedad@uc.cl.'
        when bad_condition == 0
          results[0] = 'Calidad de sueño buena'
          results[1] = 'Estimado funcionario(a), ¡Felicitaciones! Tu calidad de sueño no se ha visto interferida en el último tiempo, lo que te permite tener un sueño reparador. Identifica las estrategias que te estén favoreciendo tu buen dormir, para que puedas saber qué hacer a la hora de necesitarlo. Si te interesa saber más de este tema, escríbenos a ansiedad@uc.cl.'
      end
    end


    # End of result calculation
    results
  end

  def parse_params(params)
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
    a
  end
end
