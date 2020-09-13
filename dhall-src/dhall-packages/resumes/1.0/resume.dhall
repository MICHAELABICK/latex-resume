let types = ../types.dhall

in  [ { title = "Education"
      , data =
          types.SectionData.Education
            { gpa = 3.60
            , name = "Georgia Institute of Technology"
            , location = "Atlanta, GA"
            , dates = { from = "Aug 2016", to = "June 2020" }
            , major = "Bachelors of Science: Mechanical Engineering"
            , minor = Some "Robotics"
            , graduated = False
            , awards = "Studied abroad at Georgia Tech Lorraine in Metz, France"
            }
      }
    , { title = "Work Experience"
      , data =
          types.SectionData.Experiences
            [ types.Experience::{
              , corporation = "UCLA Recreation"
              , position = "Sailing Coordinator"
              , dates = { from = "June 2016", to = "Aug 2018" }
              , bullets = [ "Test", "Test2" ]
              }
            ]
      }
    , { title = "Academic Leadership Projects"
      , data =
          types.SectionData.Experiences
            [ types.Experience::{
              , corporation = "Robojackets"
              , position = "Team Member"
              , dates = { from = "Aug 2016", to = "April 2017" }
              , bullets = [ "Test", "Test2" ]
              }
            ]
      }
    , { title = "Technical Skills"
      , data =
          types.SectionData.Skills
            { groups =
              [ { name = "CAD", skills = [ "item1", "item2" ] }
              , { name = "Communication", skills = [ "item1", "item2" ] }
              ]
            , longest_group_title = "Communication"
            }
      }
    , { title = "Awards \\& Honors"
      , data =
          types.SectionData.Awards
            [ types.Award.TimePeriod
                { name = "Georgia Tech Dean's List"
                , from = "Dec 2016"
                , to = "to Present"
                }
            , types.Award.Placed
                { name = "Georgia Tech ME2110 Design Competition"
                , date = "Nov 2017"
                , place = "7th/60"
                }
            ]
      }
    ]
