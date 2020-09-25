let Prelude = ./Prelude.dhall

let dates = ../dates/package.dhall

let Tags/Type
    : Type
    = { old : Bool
      , cad : Bool
      , devops : Bool
      , instruments : Bool
      , webdev : Bool
      , reports : Bool
      }

let Tags =
      { Type = Tags/Type
      , default =
            { old = False
            , cad = False
            , devops = False
            , instruments = False
            , webdev = False
            , reports = False
            }
          : Tags/Type
      }

let matchTags
    : Tags.Type → Bool
    = λ(tags : Tags.Type) →
            Prelude.Bool.not tags.old
        &&  Prelude.Bool.not tags.cad
        &&  Prelude.Bool.not tags.devops
        &&  Prelude.Bool.not tags.instruments
        &&  Prelude.Bool.not tags.webdev
        &&  Prelude.Bool.not tags.reports

let types = ./types.dhall Tags.Type

let tagItem = λ(Item : Type) → λ(item : Item) → { item, tags = Tags.default }

let TaggedExperience
    : types.Experience.Type → types.Tagged.Type types.Experience.Type
    = tagItem types.Experience.Type

let TaggedAward
    : types.Award → types.Tagged.Type types.Award
    = tagItem types.Award

let TaggedText
    : Text → types.Tagged.Type Text
    = types.Tagged.tagText Tags.default

let FIRSTAward =
      { regional : Text, place : Natural, team_count : Natural, date : Text }

let toFIRSTAward =
      λ(fa : FIRSTAward) →
        types.Award.Placed
          { name = "FIRST Robotics ${fa.regional} Regional"
          , place = "${Natural/show fa.place}/${Natural/show fa.team_count}"
          , date = fa.date
          }

let education =
      [ types.SectionItem.School
          { gpa = 3.60
          , name = "Georgia Institute of Technology"
          , location = "Atlanta, GA"
          , dates =
            { from = dates.monthDayYear dates.Month.August 21 2016
            , to = dates.monthDayYear dates.Month.June 1 2020
            }
          , major = "Bachelors of Science: Mechanical Engineering"
          , minor = Some "Robotics"
          , graduated = False
          , awards = "Studied abroad at Georgia Tech Lorraine in Metz, France"
          }
      ]

let work_experience =
      [ TaggedExperience
          types.Experience::{
          , corporation = "Intuitive Surgical"
          , position = types.Position.Single "Mechanical Engineering Co-op"
          , dates =
            { from = dates.monthDayYear dates.Month.August 1 2019
            , to = dates.EndDate.Present
            }
          , bullets =
            [ "Performed verification and validation for surgical robots in the highly regulated medical device industry"
            , "Built an automated fixture using cascaded PID controllers for design verification tests"
            , "Acted as project manager for manufacturing, re-manufacturing, and sustaining engineering projects"
            , "Performed FEA failure analysis and DFM on sheet metal and thermoformed plastic parts"
            , "Performed engineering change orders and drawing updates in Agile PLM and Windchill PDM"
            ]
          }
      , TaggedExperience
          types.Experience::{
          , corporation = "GTRI Brachiating Robotics"
          , position =
              types.Position.Progression
                { last = "Undergraduate Assistant", first = "Intern" }
          , dates =
            { from = dates.monthDayYear dates.Month.April 1 2019
            , to =
                dates.EndDate.Date
                  (dates.monthDayYear dates.Month.August 1 2020)
            }
          , bullets =
            [ "Implemenented an online, quadratic programming controller in C++ for brachiating robots"
            , "Used FEA to design biomimetic, robotic manipulator jaws using the compliant mechanism methodology"
            , "Developed a novel, bi-stable linkage that improved and reduced power usage of robotic grippers"
            , "Applied machine design methodologies using MATLAB to size actuators and optimize chassis strength"
            , "Work on LQR and SOS controller design will be published in the IROS 2020 robotics conference"
            , "Awarded the Presidential Undergraduate Research Award for outstanding research"
            ]
          }
      ,   TaggedExperience
            types.Experience::{
            , corporation = "UCLA Recreation"
            , position =
                types.Position.Progression
                  { last = "Lead Sailing Coordinator", first = "Instructor" }
            , dates =
              { from = dates.monthDayYear dates.Month.June 1 2016
              , to =
                  dates.EndDate.Date
                    (dates.monthDayYear dates.Month.August 1 2018)
              }
            , bullets =
              [ "Coordinated the daily plan and goals for 20 co-workers"
              , "Responsible for safety of UCLA sailors on and off the water"
              , "Taught sailors with skill levels ranging from beginner to advanced"
              ]
            }
        ⫽ { tags = Tags::{ old = True } }
      ]

let projects =
      [ TaggedExperience
          types.Experience::{
          , corporation = "Agricultural Robotics Project Course"
          , position = types.Position.Single "Undergraduate Researcher"
          , dates =
            { from = dates.monthDayYear dates.Month.August 1 2018
            , to =
                dates.EndDate.Date (dates.monthDayYear dates.Month.April 1 2019)
            }
          , bullets =
            [ "Integrated stereo depth and SLAM LIDAR units into a standalone sensor for brachiating robots"
            , "Implemented realtime sensing and pose estimation of a flexible cable for feedback control"
            , "Processed color and depth video using openCV to identify a thin cable in harsh environmental conditions"
            , "Implemented ROS (Robot Operating System) to record, communicate, and log robot and sensor state"
            ]
          }
      , TaggedExperience
          types.Experience::{
          , corporation = "Robojackets"
          , position = types.Position.Single "Team Member"
          , dates =
            { from = dates.monthDayYear dates.Month.August 1 2016
            , to =
                dates.EndDate.Date (dates.monthDayYear dates.Month.April 1 2017)
            }
          , bullets =
            [ "Lead design of a 3lb combat robot including CAD and Design for Manufacture"
            , "Performed FEA on weapon subsystem to prevent catastrophic and fatigue failure"
            , "Manufactured robotic components using precision machinery including CNC mills, lathes, and waterjets"
            , "Created autonomous path planning and motion profile algorithm using MATLAB"
            ]
          }
      ,   TaggedExperience
            types.Experience::{
            , corporation = "GT Motorsports"
            , position = types.Position.Single "Powertrain Team Member"
            , dates =
              { from = dates.monthDayYear dates.Month.August 1 2016
              , to =
                  dates.EndDate.Date
                    (dates.monthDayYear dates.Month.April 1 2017)
              }
            , bullets =
              [ "Simulated engine dynamics to increase efficiency and low-end torque by lowering power-band"
              , "Designed improved camshaft to match optimal lift profile"
              ]
            }
        ⫽ { tags = Tags::{ old = True } }
      , TaggedExperience
          types.Experience::{
          , corporation = "MilkenKnights FRC Team"
          , position = types.Position.Single "Team Captain"
          , dates =
            { from = dates.monthDayYear dates.Month.August 1 2011
            , to =
                dates.EndDate.Date (dates.monthDayYear dates.Month.June 1 2016)
            }
          , bullets =
            [ "Used Lean and Six Sigma principles to streamline manufacturing and assembly proccess"
            , "Managed 60 students in rapid prototyping, designing, and manufacturing a robot in six weeks"
            , "Created top-down Solidworks models of transmissions, manipulators, and complex linkages"
            , "Implemented position PID, velocity PID, vision tracking, motion profiles, and path following"
            , "Trained students in CAD and operating precision machinery including a mill, lathe, and CNC router"
            ]
          }
      , TaggedExperience
          types.Experience::{
          , corporation = "3D Printing Design Project"
          , dates =
            { from = dates.monthDayYear dates.Month.August 1 2016
            , to =
                dates.EndDate.Date
                  (dates.monthDayYear dates.Month.December 1 2016)
            }
          , bullets =
            [ "Surface modeled an X-Wing, designed to be SLS printed to minimize part count and ease assembly"
            , "Performed Geometric Dimensioning and Tolerancing to ensure fit and function"
            , "Created manufacturing drawings, assembly diagrams, and sections views for a technical report"
            , "Final print is used as an example of excellent modeling technique and novel usage of SLS 3D printing"
            ]
          }
      , TaggedExperience
          types.Experience::{
          , corporation = "Creative Decisions and Design Competition"
          , dates =
            { from = dates.monthDayYear dates.Month.August 1 2017
            , to =
                dates.EndDate.Date
                  (dates.monthDayYear dates.Month.December 1 2017)
            }
          , bullets =
            [ "Utilized CAD and laser cutting techniques to enable rapid prototyping, ideation, and manufacturing"
            , "Wrote technical project reports outlining design process, decisions, and future improvements"
            , "Presented our machine, design decisions, and proccess to a panel of qualified judges"
            , "Programmed a NI myRio to execute a system of automated tasks using LabView"
            ]
          }
      ,   TaggedExperience
            types.Experience::{
            , corporation = "Conrad Spirit of Innovation"
            , position = types.Position.Single "Mechatronics Lead"
            , dates =
              { from = dates.monthDayYear dates.Month.September 1 2014
              , to =
                  dates.EndDate.Date
                    (dates.monthDayYear dates.Month.June 1 2015)
              }
            , bullets =
              [ "Designed a belt than warned the visually-impaired of hazardous obstacles"
              , "Wired and programmed a LIDAR tracking system using an Arduino microcontroller"
              ]
            }
        ⫽ { tags = Tags::{ old = True } }
      ,   TaggedExperience
            types.Experience::{
            , corporation = "Edge Systems Design"
            , position = types.Position.Single "Mechanical Engineer"
            , dates =
              { from = dates.monthDayYear dates.Month.June 1 2012
              , to =
                  dates.EndDate.Date
                    (dates.monthDayYear dates.Month.June 1 2014)
              }
            , bullets =
              [ "Designed base frame and linear motion system for an affordable CNC router"
              , "Helped manage funding and operation of a startup"
              ]
            }
        ⫽ { tags = Tags::{ old = True } }
      ]

let skills =
      [ { name = "CAD"
        , skills =
          [ TaggedText "Solidworks"
          , TaggedText "Windchill"
          , TaggedText "Solidworks Enterprise PDM~(EPDM)"
          , TaggedText "Autodesk Inventor"
          , TaggedText "Master Model" ⫽ { tags = Tags::{ cad = True } }
          , TaggedText "Top-down Design" ⫽ { tags = Tags::{ cad = True } }
          , TaggedText "Parametric Design" ⫽ { tags = Tags::{ cad = True } }
          , TaggedText "Surface Modeling" ⫽ { tags = Tags::{ cad = True } }
          ,   TaggedText "2D~\\&~3D Manufacturing/Installation Drawings"
            ⫽ { tags = Tags::{ cad = True } }
          , TaggedText "Geometric Design~\\& Tolerancing"
          , TaggedText "Design for Manufacture~(DFM)"
          , TaggedText "Design for Assembly~(DFA)"
          , TaggedText "Finite Element Analysis~(FEA)"
          , TaggedText "Simulation"
          , TaggedText "3D Modeling"
          ]
        }
      , { name = "Fabrication"
        , skills =
          [ TaggedText "G-Code"
          , TaggedText "CNC Mill"
          , TaggedText "Manual Mill"
          , TaggedText "Manual Lathe"
          , TaggedText "Laser Cutter"
          , TaggedText "Waterjet"
          , TaggedText "3D Printer"
          , TaggedText "Selective Laser Sintering~(SLS)"
          , TaggedText "Drill Press"
          , TaggedText "Bandsaw"
          , TaggedText "Soldering Iron"
          ]
        }
      , { name = "Programming"
        , skills =
          [ TaggedText "MATLAB"
          , TaggedText "Python"
          , TaggedText "Julia"
          , TaggedText "C"
          , TaggedText "C++"
          , TaggedText "Java"
          , TaggedText "Git"
          , TaggedText "Amazon Web Services~(AWS)"
          , TaggedText "Google Cloud"
          , TaggedText "Terraform" ⫽ { tags = Tags::{ devops = True } }
          , TaggedText "Ansible" ⫽ { tags = Tags::{ devops = True } }
          , TaggedText "Robot Operating System~(ROS)"
          , TaggedText "OpenCV"
          , TaggedText "Bash"
          , TaggedText "LabView"
          , TaggedText "Android"
          , TaggedText "Dhall"
          , TaggedText "HTML" ⫽ { tags = Tags::{ webdev = True } }
          , TaggedText "CSS" ⫽ { tags = Tags::{ webdev = True } }
          , TaggedText "SASS" ⫽ { tags = Tags::{ webdev = True } }
          , TaggedText "\\LaTeX"
          ]
        }
      , { name = "Mechatronics"
        , skills =
          [ TaggedText "Stereo Depth Camera"
          , TaggedText "SLAM LIDAR"
          , TaggedText "NI~cRio/myRio/roboRio"
          , TaggedText "Festo Actuators and Drives"
          , TaggedText "Arduino"
          , TaggedText "Brushless Servos"
          , TaggedText "Brushed Servos"
          , TaggedText "Hall~Effect"
          , TaggedText "Pneumatic Actuators"
          , TaggedText "Encoders"
          , TaggedText "Solenoids"
          , TaggedText "Motors"
          , TaggedText "IR~Sensors" ⫽ { tags = Tags::{ old = True } }
          , TaggedText "Sonar" ⫽ { tags = Tags::{ old = True } }
          , TaggedText "Wire Harness" ⫽ { tags = Tags::{ old = True } }
          ]
        }
      , { name = "Software"
        , skills =
          [ TaggedText "Agile PLM"
          , TaggedText "SAP"
          , TaggedText "Adobe Illustrator"
          , TaggedText "Linux"
          , TaggedText "Ubuntu"
          , TaggedText "Emacs"
          , TaggedText "Vim"
          , TaggedText "Inkscape"
          , TaggedText "Gimp"
          , TaggedText "Excel"
          , TaggedText "Word" ⫽ { tags = Tags::{ old = True } }
          , TaggedText "MacOS" ⫽ { tags = Tags::{ old = True } }
          , TaggedText "Windows" ⫽ { tags = Tags::{ old = True } }
          ]
        }
      , { name = "Instruments"
        , skills =
          [ TaggedText "Micrometer"
          , TaggedText "Caliper"
          , TaggedText "Ocilloscope"
          , TaggedText "Multimeter"
          , TaggedText "Voltmeter" ⫽ { tags = Tags::{ instruments = True } }
          ]
        }
      , { name = "Planning"
        , skills =
          [ TaggedText "Investigation"
          , TaggedText "Root Cause Analysis"
          , TaggedText "Lean Manufacturing"
          , TaggedText "Six Sigma"
          , TaggedText "Statistics"
          , TaggedText "Oral Reports" ⫽ { tags = Tags::{ reports = True } }
          , TaggedText "Technical Reports" ⫽ { tags = Tags::{ reports = True } }
          , TaggedText "Documentation"
          ,   TaggedText "Executive Summaries"
            ⫽ { tags = Tags::{ reports = True } }
          , TaggedText "Progress Reports" ⫽ { tags = Tags::{ reports = True } }
          , TaggedText "5-Whys"
          , TaggedText "DMAIC"
          , TaggedText "Project Management"
          , TaggedText "First Pronciples"
          , TaggedText "Problem Solving"
          ,   TaggedText "Bill of Materials~(BOM)"
            ⫽ { tags = Tags::{ old = True } }
          , TaggedText "House of Quality" ⫽ { tags = Tags::{ old = True } }
          , TaggedText "Specification Sheet" ⫽ { tags = Tags::{ old = True } }
          , TaggedText "Morph Chart" ⫽ { tags = Tags::{ old = True } }
          , TaggedText "Function Tree" ⫽ { tags = Tags::{ old = True } }
          , TaggedText "Gantt Chart" ⫽ { tags = Tags::{ old = True } }
          , TaggedText "Evaulation Matrix" ⫽ { tags = Tags::{ old = True } }
          ]
        }
      ]

let awards =
      [ TaggedAward
          ( types.Award.TimePeriod
              { name = "Georgia Tech Dean's List"
              , from = "Dec 2016"
              , to = "to Present"
              }
          )
      , TaggedAward
          ( types.Award.Placed
              { name = "GT Presidential Undergraduate Research Award (PURA)"
              , date = "April 2020"
              , place = ""
              }
          )
      , TaggedAward
          ( types.Award.Placed
              { name = "Georgia Tech ME2110 Design Competition"
              , date = "Nov 2017"
              , place = "7th/60"
              }
          )
      , TaggedAward
          ( toFIRSTAward
              { regional = "Orange County"
              , date = "Apr 2016"
              , place = 2
              , team_count = 42
              }
          )
      , TaggedAward
          ( toFIRSTAward
              { regional = "Ventura"
              , date = "Mar 2015"
              , place = 3
              , team_count = 41
              }
          )
      , TaggedAward
          ( toFIRSTAward
              { regional = "Utah"
              , date = "Mar 2015"
              , place = 3
              , team_count = 53
              }
          )
      ,   TaggedAward
            ( types.Award.Placed
                { name = "Conrad Spirit of Innovation Semi-Finalist"
                , date = "Oct 2014"
                , place = "International"
                }
            )
        ⫽ { tags = Tags::{ old = True } }
      ,   TaggedAward
            ( toFIRSTAward
                { regional = "Los Angeles"
                , date = "Mar 2013"
                , place = 1
                , team_count = 65
                }
            )
        ⫽ { tags = Tags::{ old = True } }
      ,   TaggedAward
            ( toFIRSTAward
                { regional = "Los Angeles"
                , date = "Mar 2012"
                , place = 2
                , team_count = 66
                }
            )
        ⫽ { tags = Tags::{ old = True } }
      ]

let toSectionItems =
      λ(exps : List (types.Tagged.Type types.Experience.Type)) →
        Prelude.List.map
          (types.Tagged.Type types.Experience.Type)
          types.SectionItem
          ( λ(x : types.Tagged.Type types.Experience.Type) →
              types.SectionItem.Experience x
          )
          exps

let content =
      [ { title = "Education", data = education }
      , { title = "Work Experience", data = toSectionItems work_experience }
      , { title = "Academic Leadership Projects"
        , data = toSectionItems projects
        }
      , { title = "Technical Skills"
        , data =
          [ types.SectionItem.Skills
              { groups = skills, longest_group_title = "Programming" }
          ]
        }
      , { title = "Awards \\& Honors"
        , data = [ types.SectionItem.Awards awards ]
        }
      ]

in  { content, Tags = Tags.Type, matchTags }
