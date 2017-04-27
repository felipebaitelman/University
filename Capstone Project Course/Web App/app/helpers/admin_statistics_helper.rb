module AdminStatisticsHelper

  # Cantidad de contenido multimedia visto por tipo
  def views_by_media_type(type)
    answer = Hash.new
    time = type
    title_graph = ''
    case time
      when 'month'
        logs =  @logs.where(:date => Time.now.beginning_of_month..Time.now.end_of_month)
        title_graph = 'ultimo mes'
      when 'year'
        logs =  @logs.where(:date => Time.now.beginning_of_year..Time.now.end_of_year)
        title_graph = 'ultimo año'
      else
        logs = @logs
        title_graph = 'acumulado'
    end
    logs.group(:media_type).count.as_json.each do |key, value|
      case key
        when 'Infographic'
          answer['Infografía'] = value
        when 'Video'
          answer['Naturaleza'] = value
        when 'Sound'
          answer['Imaginería'] = value
        when 'Program'
          answer['Programas'] = value
      end
    end
    pie_chart answer, height: '190px', width: '90%',
              colors: ["#FFC8F2", "#C0FF97", "#FFD586", "#836953"], library: {chart: { borderColor: '#aaa',
              borderWidth: 2, type: 'line',backgroundColor: '#FEFEFA', style: {fontFamily: 'Helvetica Neue'
        }},
        title: {text: "Vistas por tipo de contenido #{title_graph}", style: {fontWeight: 'bold', fontSize: '14px'}},
        yAxis: {
            allowDecimals: false,
            title: {
                text: 'Media types count'
            }
        },
        xAxis: {
            title: {
                text: 'Media type'
            }
        },
    }
  end

  # Logs por mes
  def logs_by_month(type)
    result = Hash.new(0)
    time = type
    title_graph = ''
    case time
      when 'month'
        logs =  @logs.where(:date => Time.now.beginning_of_month..Time.now.end_of_month)
        logs.group_by{ |m| m.date.beginning_of_day}.each do |key, value|
          aux = key.to_s.split('-')
          result["#{aux[2].split(' ')[0]}-#{aux[1]}-#{aux[0]}"] = value.count
        end
        title_graph = 'Reproducciones durante el mes'
        x_axsis = 'Días'
      when 'year'
        logs =  @logs.where(:date => Time.now.beginning_of_year..Time.now.end_of_year)
        logs.group_by{ |m| m.date.beginning_of_month }.each do |key, value|
          aux = key.to_s.split('-')
          result["#{aux[1]}-#{aux[0]}"] = value.count
        end
        title_graph = 'Reproducciones por meses ultimo año'
        x_axsis = 'Meses'
      else
        logs = @logs
        logs.group_by{ |m| m.date.beginning_of_year}.each do |key, value|
          aux = key.to_s.split('-')
          result["#{aux[0]}"] = value.count
        end
        title_graph = 'Reproducciones por años'
        x_axsis = 'Años'
    end
    line_chart result.sort, height: '80%',
               width: '95%', colors: ["#FFD586"],
               library: {
                   chart: { borderColor: '#aaa',
                            borderWidth: 2, type: 'line',backgroundColor: '#FEFEFA',
                            style: {fontFamily: 'Helvetica Neue'
                            }
                   },
                   title: {text: title_graph, style: {fontWeight: 'bold', fontSize: '14px'}},
                   yAxis: {
                       allowDecimals: false,
                       title: {
                           text: 'Reprodución de Contenido'
                       }
                   },
                   xAxis: {
                       title: {
                           text: x_axsis
                       }
                   }
    }
  end

  # Cantidad vista de imaginerias
  def imagery_by_views(type)
    result = Hash.new(0)
    time = type
    title_graph = ''
    case time
      when 'month'
        logs =  @logs.where(:date => Time.now.beginning_of_month..Time.now.end_of_month)
        title_graph = 'ultimo mes'
      when 'year'
        logs =  @logs.where(:date => Time.now.beginning_of_year..Time.now.end_of_year)
        title_graph = 'ultimo año'
      else
        logs = @logs
        title_graph = 'acumuladas'
    end
    logs.where(media_type:"Sound").group(:media_id).count.each do |key, value|
      if Sound.exists?(key)
        if Sound.find(key).program === false
          result[Sound.find(key).name] = value
        end
      end
    end
    column_chart result, height: '400px', width: '90%', colors: ["#FFD586"],
                 library: {
                     chart: { borderColor: '#aaa', borderWidth: 2,
                              type: 'line',backgroundColor: '#FEFEFA',
                              style: {
                                  fontFamily: 'Helvetica Neue'
                              }
                     },
                     title: {
                         text: "Imaginerías vistas #{title_graph}",
                         style: {
                             fontWeight: 'bold', fontSize: '14px'
                         }
                     },
                     yAxis: {
                         allowDecimals: false,
                     },
                     xAxis: {
                     }
                 }
  end

  # Cantidad vista de secuencias
  def infographics_by_views(type)
    result = Hash.new(0)
    time = type
    title_graph = ''
    case time
      when 'month'
        logs =  @logs.where(:date => Time.now.beginning_of_month..Time.now.end_of_month)
        title_graph = 'ultimo mes'
      when 'year'
        logs =  @logs.where(:date => Time.now.beginning_of_year..Time.now.end_of_year)
        title_graph = 'ultimo año'
      else
        logs = @logs
        title_graph = 'acumulado'
    end
    logs.where(media_type:"Infographic").group(:media_id).count.each do |key, value|
      case key
        when 1
          result['Concéntrate'] = value
        when 2
          result['Desactívate'] = value
        when 3
          result['Empodérate'] = value
      end
    end
    column_chart result, height: '80%', width: '80%', colors: ["#C0FF97"],
                 library: {
                     chart: {
                         borderColor: '#aaa',  borderWidth: 2, type: 'line',
                         backgroundColor: '#FEFEFA',
                         style: {
                             fontFamily: 'Helvetica Neue'
                         }
                     },
                     title: {
                           text: "Vistas de Secuencias por tipo #{title_graph}",
                         style: {
                             fontWeight: 'bold', fontSize: '14px'
                         }
                     },
                     yAxis: {
                         allowDecimals: false,
                     },
                     xAxis: {
                     }
    }
  end

  # Cantidad total de usuarios (sin contar administradores)
  def user_count(type)
    result = Hash.new(0)
    time = type
    title_graph = ''
    case time
      when 'month'
        users =  @users.where(:created_at => Time.new(2015)..Time.now.beginning_of_month)
        title_graph = 'a principio del mes'

      when 'year'
        users =  @users.where(:created_at => Time.new(2015)..Time.now.beginning_of_year)
        title_graph = 'a principio del año'
      else
        users = @users
        title_graph = 'al día'
    end
    users.group(:academic_type).count.each do |key, value|
      result[key] = value
    end
    bar_chart result, height: '300px;', width: '100%', colors: ["#FFC8F2"],
              library: {
                  chart: {
                      borderColor: '#aaa', borderWidth: 2, type: 'line',backgroundColor: '#FEFEFA',
                      style: {
                          fontFamily: 'Helvetica Neue'
                      }
                  },
                  title: {
                      text: "Cantidad de usuarios #{title_graph}",
                      style: {
                          fontWeight: 'bold', fontSize: '14px'
                      }
                  },
                  yAxis: {
                      allowDecimals: false,
                  },
                  xAxis: {
                  }
    }
  end

  # Cantidad de usuarios registrados por mes
  def user_count_by_month(type)
    result = Hash.new(0)
    time = type
    title_graph = ''
    x_axsis = ''
    case time
      when 'month'
        users =  @users.where(:created_at => Time.now.beginning_of_month..Time.now.end_of_month)
        users.group_by{ |m| m.created_at.beginning_of_day}.each do |key, value|
          aux = key.to_s.split('-')
          result["#{aux[2].split(' ')[0]}-#{aux[1]}-#{aux[0]}"] = value.count
        end
        title_graph = 'Usuarios nuevos durante el ultimo mes'
        x_axsis = 'Días'
      when 'year'
        users =  @users.where(:created_at => Time.now.beginning_of_year..Time.now.end_of_year)
        users.group_by{ |m| m.created_at.beginning_of_month }.each do |key, value|
          aux = key.to_s.split('-')
          result["#{aux[1]}-#{aux[0]}"] = value.count
        end
        title_graph = 'Usuarios nuevos durante el ultimo año'
        x_axsis = 'Meses'
      else
        users = @users
        users.group_by{ |m| m.created_at.beginning_of_year}.each do |key, value|
          aux = key.to_s.split('-')
          result["#{aux[0]}"] = value.count
        end
        title_graph = 'Usuarios nuevos durante los años'
        x_axsis = 'Años'
    end
    line_chart result.sort, height: '80%', width: '95%', colors: ["#FFD586"],
               library: {
                   chart: {
                       borderColor: '#aaa', borderWidth: 2, type: 'line',backgroundColor: '#FEFEFA',
                       style: {
                           fontFamily: 'Helvetica Neue'
                       }
                   },
                   title: {
                       text: title_graph,
                       style: {
                           fontWeight: 'bold', fontSize: '14px'
                       }
                   },
                   yAxis: {
                       allowDecimals: false,
                       title: {
                           text: 'Usuarios'
                       }
                   },
                   xAxis: {
                       title: {
                           text: x_axsis
                       }
                   }
    }
  end

  # Cantidad de alumnos por carrera
  def user_count_by_career(type)
    result = Hash.new(0)
    time = type
    title_graph = ''
    case time
      when 'month'
        users =  @users.where(:current_sign_in_at => Time.now.beginning_of_month..Time.now.end_of_month)
        title_graph = 'activos ultimo mes'
      when 'year'
        users =  @users.where(:current_sign_in_at => Time.now.beginning_of_year..Time.now.end_of_year)
        title_graph = 'activos ultimo año'
      else
        title_graph = 'acumulado'
        users = @users
    end
    users.where(academic_type:"Alumno").group(:school).count.each do |key, value|
      result[key] = value
    end
    column_chart result, height: '400px', width: '90%', colors: ["#C0FF97"],
                 library: {
                     chart: {
                         borderColor: '#aaa', borderWidth: 2, type: 'line',backgroundColor: '#FEFEFA',
                         style: {
                             fontFamily: 'Helvetica Neue'
                         }
                     },
                     title: {
                         text: "Alumnos por carrera #{title_graph}",
                         style: {
                             fontWeight: 'bold', fontSize: '14px'
                         }
                     },
                     yAxis: {
                         allowDecimals: false,
                     },
                     xAxis: {
                     }
    }
  end

  # Cantidad de alumnos por género
  def user_count_by_gender(type)
    result = Hash.new(0)
    time = type
    title_graph = ''
    case time
      when 'month'
        users =  @users.where(:created_at => Time.new(2015)..Time.now.beginning_of_month)
        title_graph = 'a principio del mes'
      when 'year'
        users =  @users.where(:created_at => Time.new(2015)..Time.now.beginning_of_year)
        title_graph = 'a principio del año'
      else
        users = @users
        title_graph = 'al día'
    end
    users.where(academic_type:"Alumno").group(:sex).count.each do |key, value|
      result[key] = value
    end
    bar_chart result, height: '190px', width: '90%', colors: ["#FFC8F2"],
              library: {
                  chart: {
                      borderColor: '#aaa', borderWidth: 2, type: 'line',backgroundColor: '#FEFEFA',
                      style: {
                          fontFamily: 'Helvetica Neue'
                      }
                  },
                  title: {
                      text: "Alumnos por género #{title_graph}",
                      style: {
                          fontWeight: 'bold', fontSize: '14px'}
                  },
                  yAxis: {
                      allowDecimals: false,

                  },
                  xAxis: {
                  }
    }
  end

  # Cantidad de alumnos por año cursado
  def user_count_by_career_year(type)
    result = Hash.new(0)
    time = type
    title_graph = ''
    case time
      when 'month'
        users =  @users.where(:current_sign_in_at => Time.now.beginning_of_month..Time.now.end_of_month)
        title_graph = 'activos ultimo mes'
      when 'year'
        users =  @users.where(:current_sign_in_at => Time.now.beginning_of_year..Time.now.end_of_year)
        title_graph = 'activos ultimo año'
      else
        title_graph = 'acumulado'
        users = @users
    end
    users.where(academic_type:"Alumno").group(:year).count.each do |key, value|
      result[key] = value
    end
    pie_chart result, height: '200px', width: '100%',
              colors: ["#FFC8F2", "#C0FF97", "#FFD586","#836953", "#FF9966", "#DE5D83"],
              library: {
                  chart: {
                      borderColor: '#aaa', borderWidth: 2, type: 'line',backgroundColor: '#FEFEFA',
                      style: {
                          fontFamily: 'Helvetica Neue'}
                  },
                  title: {
                      text: "Alumnos por año de ingreso #{title_graph}",
                      style: {
                          fontWeight: 'bold', fontSize: '14px'}
                  },
                  yAxis: {
                      allowDecimals: false,
                      title: {
                          text: 'Media types count'
                      }
                  },
                  xAxis: {
                      title: {
                          text: 'Media type'
                      }
                  }
        }
  end

  # Cantidad de funcionarios por género
  def worker_count_by_gender(type)
    result = Hash.new(0)
    time = type
    title_graph = ''
    case time
      when 'month'
        users =  @users.where(:created_at => Time.new(2015)..Time.now.beginning_of_month)
        title_graph = 'a principio del mes'
      when 'year'
        users =  @users.where(:created_at => Time.new(2015)..Time.now.beginning_of_year)
        title_graph = 'a principio del año'
      else
        users = @users
        title_graph = 'al día'
    end
    users.where(academic_type:"Funcionario").group(:sex).count.each do |key, value|
      result[key] = value
    end
    bar_chart result, height: '400px', width: '90%', colors: ["#FFD586"],
              library: {
                  chart: {
                      borderColor: '#aaa', borderWidth: 2, type: 'line',backgroundColor: '#FEFEFA',
                      style: {
                          fontFamily: 'Helvetica Neue'
                      }
                  },
                  title: {
                      text: "Funcionario por género #{title_graph}",                      style: {
                          fontWeight: 'bold', fontSize: '14px'
                      }
                  },
                  yAxis: {
                      allowDecimals: false,

                  },
                  xAxis: {
                  }
    }
  end
end