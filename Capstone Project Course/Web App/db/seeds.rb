# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Topic.where(name: 'Concéntrate').first_or_create
Topic.where(name: 'Desactívate').first_or_create
Topic.where(name: 'Empodérate').first_or_create

Day.where(day: "Monday", spanish_day: "Lunes").first_or_create
Day.where(day: "Tuesday", spanish_day: "Martes").first_or_create
Day.where(day: "Wednesday", spanish_day: "Miércoles").first_or_create
Day.where(day: "Thursday", spanish_day: "Jueves").first_or_create
Day.where(day: "Friday", spanish_day: "Viernes").first_or_create

Faculty.where(name:  "San Joaquín").first_or_create
Faculty.where(name:  "Lo Contador").first_or_create
Faculty.where(name:  "Casa Central").first_or_create
Faculty.where(name:  "Campus Oriente").first_or_create
Faculty.where(name:  "Villarrica").first_or_create

EventType.where(name:  "Consejería").first_or_create
EventType.where(name:  "Apoyo Grupal").first_or_create
EventType.where(name:  "Taller de Mindfulness").first_or_create
EventType.where(name:  "Taller de Yoga").first_or_create

unless User.where(email: 'dsinay@uc.cl').first
  user = User.new(email: 'dsinay@uc.cl', password: '123123', tokens: nil, admin: true, name: 'Diego Sinay', academic_type:'Alumno', sex: 'Masculino',
                  age: '25', school: 'Ingeniería', year: 2011, rut:17703808, super_admin:true)
  user.skip_confirmation!
  user.save!
end

unless User.where(email: 'mpjana@uc.cl').first
  user = User.new(email: 'mpjana@uc.cl', password: '1234561', tokens: nil, admin: true, name: 'María Paz Jana', academic_type:'Funcionario', sex: 'Femenino',
                  age: '28', school: 'Psicología', rut:17703808, super_admin:true)
  user.skip_confirmation!
  user.save!
end

unless User.where(email: 'mtbarrig@uc.cl').first
  user = User.new(email: 'mtbarrig@uc.cl', password: '1234561', tokens: nil, admin: true, name: 'María Trinidad Barriga', academic_type:'Funcionario', sex: 'Femenino',
                  age: '28', school: 'Psicología', rut:17703808, super_admin:true)
  user.skip_confirmation!
  user.save!
end

unless User.where(email: 'mzuzulic@uc.cl').first
  user = User.new(email: 'mzuzulic@uc.cl', password: '1234561', tokens: nil, admin: true, name: 'María Soledad Zuzulich', academic_type:'Funcionario', sex: 'Femenino',
                  age: '28', school: 'Psicología', rut:17703808, super_admin:true)
  user.skip_confirmation!
  user.save!
end

if ENV['infographic']
  Infographic.where(name: 'Concentrate').first_or_create(
      added_by: 1, description: '', topics: Topic.where(name:'Concéntrate'))

  unless Image.exists?(name: 'Postura de la palmera')
    Image.create({name: 'Postura de la palmera', description: 'Eleva tus brazos, entrecruzas tus dedos, manteniendo índices juntos. Contraes la musculatura de tus muslos y con la inhalación elevas tus talones. Mantente mirando un punto fijo por 3 respiraciones y para bajar, lo haces junto a tu exhalación',
                  added_by: 1, image_file: File.new("#{Rails.root}/public/Concentrate/1P.jpg")})
  end

  unless Image.exists?(name: 'Postura del árbol')
    Image.create({name: 'Postura del árbol', description: 'Eleva tus brazos, entrecruzas tus dedos, manteniendo índices juntos. Flexiona una de tus rodillas, llevando la planta del pie contra el muslo interno de la pierna contraria. Mantente mirando un punto fijo por 3 respiraciones y para bajar, exhalas.  No te olvides de realizar la postura con la pierna contraria',
                  added_by: 1, image_file: File.new("#{Rails.root}/public/Concentrate/2A.jpg")})
  end

  unless Image.exists?(name: 'Postura de la vara en equilibrio')
    Image.create({name: 'Postura de la vara en equilibrio', description: ' Eleva tus brazos entrecruzando tus dedos y manteniendo índices juntos. Mientras estiras una de tus piernas hacia atrás, llevas tu pecho hacia adelante manteniendo así el equilibrio. Realiza esta postura por 3 respiraciones. No te olvides de realizar la postura con la pierna contraria',
                  added_by: 1, image_file: File.new("#{Rails.root}/public/Concentrate/3V.jpg")})
  end

  unless Image.exists?(name: 'Torsión simple')
    Image.create({name: 'Torsión simple', description: 'Cruza tus piernas y colocas una mano contra la rodilla contraria, como una palanca. Exhalando llevas el otro brazo hacia atrás, y apoyas la mano en copa en el suelo, mantén esta postura por 3 respiraciones. No te olvides de realizar la torsión hacia el otro lado',
                  added_by: 1, image_file: File.new("#{Rails.root}/public/Concentrate/4T.jpg")})
  end

  unless Image.exists?(name: 'Postura de descanso sentado')
    Image.create({name: 'Postura de descanso sentado', description: ' separas tus piernas, llevando la punta de tus pies hacia afuera y tus brazos hacia atrás. Con una inhalación profunda, arqueas levemente tu columna y dejas caer tu cabeza relajada. Cierra tus ojos y respiras. Descansa en esta postura. Mantén 5 respiraciones profundas',
                  added_by: 1, image_file: File.new("#{Rails.root}/public/Concentrate/5D.jpg")})
  end

  ImageSequence.where(infographic_id: 1, image_id: 1, order: 1).first_or_create
  ImageSequence.where(infographic_id: 1, image_id: 2, order: 2).first_or_create
  ImageSequence.where(infographic_id: 1, image_id: 3, order: 3).first_or_create
  ImageSequence.where(infographic_id: 1, image_id: 4, order: 4).first_or_create
  ImageSequence.where(infographic_id: 1, image_id: 5, order: 5).first_or_create


  Infographic.where(name: 'Desactívate').first_or_create(
      added_by: 1, description: '', topics: Topic.where(name:'Desactívate'))

  unless Image.exists?(name: 'Postura de manos a pies')
    Image.create({name: 'Postura de manos a pies ', description: 'exhalando flexiona tu cadera y permite que el peso de tu cuerpo caiga. Mantén por 5 respiraciones completas',
                  added_by: 1, image_file: File.new("#{Rails.root}/public/Desactivate/1P.jpg")})
  end

  unless Image.exists?(name: 'Postura de la cabeza hacia rodilla')
    Image.create({name: 'Postura de la cabeza hacia rodilla', description: 'te sientas, y flexionas tu rodilla izquierda llevando el pie izquierdo hacia tu muslo interno derecho. Luego de una inhalación, exhalando avanzas a tomar tu pantorrilla o pie. Mantén unas 3 respiraciones. Luego inhalando, elevas tus brazos y desarmas. Realizas la flexión con la otra pierna',
                  added_by: 1, image_file: File.new("#{Rails.root}/public/Desactivate/2R.jpg")})
  end

  unless Image.exists?(name: 'Postura del arado')
    Image.create({name: 'Postura del arado', description: 'Recostado en el suelo, lleva tus piernas por atrás de tu cabeza. Coloca los dedos de los pies en el suelo. Puedes flexionar rodillas si tus pies no llegan cómodamente. Los brazos permanecen sobre el suelo, con dedos entrecruzados. Mantén 3 respiraciones y luego, regresas suavemente con las rodillas flexionadas',
                  added_by: 1, image_file: File.new("#{Rails.root}/public/Desactivate/3A.jpg")})
  end

  unless Image.exists?(name: 'Postura del pez')
    Image.create({name: 'Postura del pez', description: 'Recostado en el suelo, con las piernas estiradas y los pies juntos, ubica las palmas de las manos al costado del cuerpo. Luego de una inhalación levantas el pecho haciendo un arco tu columna, y llevas los hombros en dirección al suelo. Mantén por 3 respiraciones. Luego inhalas, llevas el mentón hacia el pecho y exhalando te recuestas',
                  added_by: 1, image_file: File.new("#{Rails.root}/public/Desactivate/4P.jpg")})
  end

  unless Image.exists?(name: 'Postura de relajación')
    Image.create({name: 'Postura de relajación', description: ' Recostado en el suelo, con tus piernas levemente separadas, y tus brazos al costado del cuerpo. Ubica tus palmas hacia arriba, y tu mentón levemente hacia el pecho. Mantén por 3 minutos',
                  added_by: 1, image_file: File.new("#{Rails.root}/public/Desactivate/5R.jpg")})
  end

  ImageSequence.where(infographic_id: 2, image_id: 6, order: 1).first_or_create
  ImageSequence.where(infographic_id: 2, image_id: 7, order: 2).first_or_create
  ImageSequence.where(infographic_id: 2, image_id: 8, order: 3).first_or_create
  ImageSequence.where(infographic_id: 2, image_id: 9, order: 4).first_or_create
  ImageSequence.where(infographic_id: 2, image_id: 10, order: 5).first_or_create


  Infographic.where(name: 'Empodérate').first_or_create(
      added_by: 1, description: '', topics: Topic.where(name:'Empodérate'))

  unless Image.exists?(name: 'Postura del guerrero')
    Image.create({name: 'Postura del guerrero', description: 'Da un gran paso hacia atrás con una de ellas, y gira levemente tu pie. Flexiona la rodilla de la pierna contraria alineada con tu talón. Mantén esta postura por 3 respiraciones',
                  added_by: 1, image_file: File.new("#{Rails.root}/public/Empoderate/1G.jpg")})
  end

  unless Image.exists?(name: 'Postura de la plancha en 4 apoyos')
    Image.create({name: 'Postura de la plancha en 4 apoyos', description: 'Desde un costado del mat, flexiona tus caderas hasta que finalmente puedas apoyar tus manos. Sin mover tus pies, camina con tus manos hasta que estén en línea con tus hombros. Quédate en esta posición por 3 respiraciones',
                  added_by: 1, image_file: File.new("#{Rails.root}/public/Empoderate/2P.jpg")})
  end

  unless Image.exists?(name: 'Postura de la montaña')
    Image.create({name: 'Postura de la montaña', description: 'Cruza tus piernas. Inhala y eleva los brazos, extendiendo los codos y juntando tus palmas. Asegúrate de distanciar los hombros de tus orejas. Mantén esta postura por 3 respiraciones',
                  added_by: 1, image_file: File.new("#{Rails.root}/public/Empoderate/3M.jpg")})
  end

  unless Image.exists?(name: 'Postura del rayo en extensión')
    Image.create({name: 'Postura del rayo en extensión', description: 'Flexiona tus rodillas y siéntate permitiendo que tus glúteos vayan hacia tus talones, colocas tus manos en el suelo, atrás de tus caderas y luego de una inhalación, arqueando tu columna. Mantén esta postura por 3 respiraciones',
                  added_by: 1, image_file: File.new("#{Rails.root}/public/Empoderate/4R.jpg")})
  end

  unless Image.exists?(name: 'Postura del niño')
    Image.create({name: 'Postura del niño', description: 'Te sientas en tus talones llevando tus brazos por el costado del cuerpo. Si tu cabeza no llega al piso, coloca un puño sobre otro y colocar tu cabeza encima de ellos. Descansa por al menos 5 respiraciones',
                  added_by: 1, image_file: File.new("#{Rails.root}/public/Empoderate/5D.jpg")})
  end

  ImageSequence.where(infographic_id: 3, image_id: 11, order: 1).first_or_create
  ImageSequence.where(infographic_id: 3, image_id: 12, order: 2).first_or_create
  ImageSequence.where(infographic_id: 3, image_id: 13, order: 3).first_or_create
  ImageSequence.where(infographic_id: 3, image_id: 14, order: 4).first_or_create
  ImageSequence.where(infographic_id: 3, image_id: 15, order: 5).first_or_create
end

if ENV['program']

  Program.where(name: 'Programa Semanal Basico', description: "").first_or_create

  unless Sound.exists?(name: 'Día 1')
    Sound.create({name: 'Día 1', description: '', added_by: 1,
                  sound_file: File.new("#{Rails.root}/public/Programa/Dia_1_ok.mp3"),program: true})
  end

  unless Sound.exists?(name: 'Día 2')
    Sound.create({name: 'Día 2', description: '', added_by: 1,
                  sound_file: File.new("#{Rails.root}/public/Programa/Dia_2_ok.mp3"),program: true})
  end

  unless Sound.exists?(name: 'Día 3')
    Sound.create({name: 'Día 3', description: '', added_by: 1,
                  sound_file: File.new("#{Rails.root}/public/Programa/Dia_3_ok.mp3"),program: true})
  end

  unless Sound.exists?(name: 'Día 4')
    Sound.create({name: 'Día 4', description: '', added_by: 1,
                  sound_file: File.new("#{Rails.root}/public/Programa/Dia_4_ok.mp3"),program: true})
  end

  unless Sound.exists?(name: 'Día 5')
    Sound.create({name: 'Día 5', description: '', added_by: 1,
                  sound_file: File.new("#{Rails.root}/public/Programa/Dia_5_ok.mp3"),program: true})
  end

  SoundSequence.where(program_id: 1, sound_id: 1, order: 1).first_or_create
  SoundSequence.where(program_id: 1, sound_id: 2, order: 2).first_or_create
  SoundSequence.where(program_id: 1, sound_id: 3, order: 3).first_or_create
  SoundSequence.where(program_id: 1, sound_id: 4, order: 4).first_or_create
  SoundSequence.where(program_id: 1, sound_id: 5, order: 5).first_or_create
end

if ENV['long_audio']

  unless Sound.exists?(name: 'Escaner Corporal')
    Sound.create({name: 'ImagineriaEN', description: '', added_by: 1,
                  sound_file: File.new("#{Rails.root}/public/Sounds/Escaner_corporal_ok.mp3"), program: false})
  end

  unless Sound.exists?(name: 'Imagenería de la Cima')
    Sound.create({name: 'Imagenería de la Cima', description: '', added_by: 1,
                  sound_file: File.new("#{Rails.root}/public/Sounds/Imageniria_de_la_Cima_ok.mp3"), program: false})
  end

  unless Sound.exists?(name: 'Imagenería de Aire')
    Sound.create({name: 'Imagenería de Aire', description: '', added_by: 1,
                  sound_file: File.new("#{Rails.root}/public/Sounds/Imagineria_de_Aire_ok.mp3"), program: false})
  end

  unless Sound.exists?(name: 'Imagenería de Invierno')
    Sound.create({name: 'Imagenería de Invierno', description: '', added_by: 1,
                  sound_file: File.new("#{Rails.root}/public/Sounds/Imagineria_de_Invierno_ok.mp3"), program: false})
  end

  unless Sound.exists?(name: 'Imagenería de Playa')
    Sound.create({name: 'Imagenería de Playa', description: '', added_by: 1,
                  sound_file: File.new("#{Rails.root}/public/Sounds/Imagineria_de_Playa.mp3"), program: false})
  end

  unless Sound.exists?(name: 'Imagenería de Campo')
    Sound.create({name: 'Imagenería de Campo', description: '', added_by: 1,
                  sound_file: File.new("#{Rails.root}/public/Sounds/Imagineria_del_Campo.mp3"), program: false})
  end

  unless Sound.exists?(name: 'Mini Imaginería')
    Sound.create({name: 'Mini Imaginería', description: '', added_by: 1,
                  sound_file: File.new("#{Rails.root}/public/Sounds/Mini_Imagineria_ok.mp3"), program: false})
  end

  unless Sound.exists?(name: 'Mini Masaje')
    Sound.create({name: 'Mini Masaje', description: '', added_by: 1,
                  sound_file: File.new("#{Rails.root}/public/Sounds/Mini_Masaje_ok.mp3"), program: false})
  end

  unless Sound.exists?(name: 'Mini Mindfullness')
    Sound.create({name: 'Mini Mindfullness', description: '', added_by: 1,
                  sound_file: File.new("#{Rails.root}/public/Sounds/Mini_Mindfullness_ok.mp3"), program: false})
  end

  unless Sound.exists?(name: 'Mini Respiración')
    Sound.create({name: 'Mini Respiración', description: '', added_by: 1,
                  sound_file: File.new("#{Rails.root}/public/Sounds/Mini_Respiración.mp3"), program: false})
  end

  unless Sound.exists?(name: 'Mini Yoga Nidra')
    Sound.create({name: 'Mini Yoga Nidra', description: '', added_by: 1,
                  sound_file: File.new("#{Rails.root}/public/Sounds/Mini_Yoga_Nidra.mp3"), program: false})
  end

  unless Sound.exists?(name: 'Relajacion de Jacobson')
    Sound.create({name: 'Relajación de Jacobson', description: '', added_by: 1,
                  sound_file: File.new("#{Rails.root}/public/Sounds/Relajacion_de_Jacobson_ok.mp3"), program: false})
  end
end

if ENV['nature']
  unless Video.exists?(name: 'Campo')
    Video.create({name: 'Campo', description: 'Atardecer en el campo con el viento corriendo', added_by: 1,
                  video_file: File.new("#{Rails.root}/public/Videos/Grass.mp4")})
  end

  unless Video.exists?(name: 'Lluvia')
    Video.create({name: 'Lluvia', description: 'Lluvia corriendo sobre las hojas', added_by: 1,
                  video_file: File.new("#{Rails.root}/public/Videos/rain.mp4") })
  end

  unless Video.exists?(name: 'Atardecer')
    Video.create({name: 'Atardecer', description: 'Atardecer calipso tropical', added_by: 1,
                  video_file: File.new("#{Rails.root}/public/Videos/sunset2.mp4")})
  end

  unless Video.exists?(name: 'Cascada')
    Video.create({name: 'Cascada', description: 'Una fuerte cascada en un día luminoso', added_by: 1,
                  video_file: File.new("#{Rails.root}/public/Videos/waterfall2.mp4") })
  end

  unless Video.exists?(name: 'Lago')
    Video.create({name: 'Lago', description: 'Tranquilo lago con patos.', added_by: 1,
                  video_file: File.new("#{Rails.root}/public/Videos/lake2.mp4") })
  end

  unless Video.exists?(name: 'Playa')
    Video.create({name: 'Playa', description: 'Playa caribeña soleada', added_by: 1,
                  video_file: File.new("#{Rails.root}/public/Videos/Playa.mp4") })
  end
end