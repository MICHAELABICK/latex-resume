let Prelude = ./Prelude.dhall

let dates = ../dates/package.dhall

let MechanicalTags =
      λ(t : Type) →
      λ(d : t) →
        { Type =
            { cad : t
            , mechanical : t
            , instruments : t
            , manufacturing : t
            , sensor : t
            }
        , default =
          { cad = d
          , mechanical = d
          , instruments = d
          , manufacturing = d
          , sensor = d
          }
        }

let CsTags =
      λ(t : Type) →
      λ(d : t) →
        { Type =
            { cloud : t
            , robotics : t
            , machine_learning : t
            , vision : t
            , devops : t
            , functional_programming : t
            , programming : t
            , apps : t
            , webdev : t
            }
        , default =
          { cloud = d
          , devops = d
          , robotics = d
          , machine_learning = d
          , vision = d
          , functional_programming = d
          , programming = d
          , apps = d
          , webdev = d
          }
        }

let SoftTags =
      λ(t : Type) →
      λ(d : t) →
        { Type =
            { problem_solving : t
            , creative : t
            , communication : t
            , reports : t
            , documentation : t
            , chart : t
            , planning : t
            , conflict_resolution : t
            }
        , default =
          { problem_solving = d
          , creative = d
          , communication = d
          , reports = d
          , documentation = d
          , chart = d
          , planning = d
          , conflict_resolution = d
          }
        }

let MiscTags =
      λ(t : Type) →
      λ(d : t) →
        { Type = { full : t, sailing : t }
        , default = { full = d, sailing = d }
        }

let Tags =
      λ(t : Type) →
      λ(d : t) →
        let mechanical = MechanicalTags t d

        let cs = CsTags t d

        let soft = SoftTags t d

        let misc = MiscTags t d

        let Tags/Type
            : Type
            = mechanical.Type ⩓ cs.Type ⩓ soft.Type ⩓ misc.Type

        in  { Type = Tags/Type
            , default =
                  mechanical.default ⫽ cs.default ⫽ soft.default ⫽ misc.default
                : Tags/Type
            }

let TagList = Tags Bool False

let types = ./types.dhall

let FIRSTEvent = < Regional : Text | ChampionshipDivision : Text >

let FIRSTAward =
      { event : FIRSTEvent, place : Natural, team_count : Natural, date : Text }

let toFIRSTAward =
      λ(fa : FIRSTAward) →
        types.Award.Placed
          { name =
              merge
                { Regional =
                    λ(regional : Text) → "FIRST Robotics ${regional} Regional"
                , ChampionshipDivision =
                    λ(division : Text) →
                      "FIRST Robotics World Championship: ${division} Division"
                }
                fa.event
          , place =
              "\\nth{${Natural/show fa.place}}/${Natural/show fa.team_count}"
          , date = fa.date
          }

let education =
      [ types.SectionItem.School
          { gpa = 3.60
          , name = "Georgia Institute of Technology"
          , location = "Atlanta, GA"
          , dates =
            { from = dates.monthDayYear dates.Month.August 21 2016
            , to = dates.monthDayYear dates.Month.May 8 2021
            }
          , major = "Bachelor's of Science: Mechanical Engineering"
          , minor = Some "Robotics"
          , graduated = False
          , awards = "Studied abroad at Georgia Tech Lorraine in Metz, France"
          }
      ]

let side_projects =
      [ types.Project::{
        , name = "Algo-trading"
        , dates =
          { from = dates.monthDayYear dates.Month.August 5 2019
          , to = dates.EndDate.Present
          }
        , summary =
            ''
            Utilized Python PyTorch deep learning framework
            to create a neural network for algorithmic trading strategies.
            Experimented with reinforcement learning in Julia.
            ''
        }
      , types.Project::{
        , name = "Homelab"
        , dates =
          { from = dates.monthDayYear dates.Month.October 7 2018
          , to = dates.EndDate.Present
          }
        , summary =
            ''
            Developed custom tooling and infrastructure stack to
            repurposed enterprise hardware.
            Using Docker, Terraform, and Kubernetes
            to practice devops paradigms
            of declarative and immutable deployments.
            ''
        }
      , types.Project::{
        , name = "GT Robotics Competition"
        , dates =
          { from = dates.monthDayYear dates.Month.August 1 2017
          , to =
              dates.EndDate.Date
                (dates.monthDayYear dates.Month.December 1 2017)
          }
        , summary =
            ''
            Utilized CAD and rapid prototyping techniques, including laser cutting and 3D printing,
            to be 1/60 teams to accomplish hardest design challenge.
            Placed \nth{7} overall.
            ''
        , bullets =
          [ "Utilized CAD and laser cutting techniques to enable rapid prototyping, ideation, and manufacturing"
          , "Wrote technical project reports outlining design process, decisions, and future improvements"
          , "Presented our machine, design decisions, and proccess to a panel of qualified judges"
          , "Programmed a NI myRio to execute a system of automated tasks using LabView"
          ]
        }
      , types.Project::{
        , name = "GT CAD Course: X-Wing"
        , dates =
          { from = dates.monthDayYear dates.Month.August 1 2016
          , to =
              dates.EndDate.Date
                (dates.monthDayYear dates.Month.December 1 2016)
          }
        , summary =
            ''
            Exceeded expectations by self-learning surface modeling techniques in SolidWorks.
            Result is used as course example of novel usage of SLS 3D printing technology.
            ''
        , bullets =
          [ "Surface modeled an X-Wing, designed to be SLS printed to minimize part count and ease assembly"
          , "Performed Geometric Dimensioning and Tolerancing to ensure fit and function"
          , "Created manufacturing drawings, assembly diagrams, and sections views for a technical report"
          , "Final print is used as an example of excellent modeling technique and novel usage of SLS 3D printing"
          ]
        }
      ]

let toSectionItems =
      λ(exps : List (Optional types.Experience.Type)) →
        Prelude.List.map
          types.Experience.Type
          types.SectionItem
          (λ(x : types.Experience.Type) → types.SectionItem.Experience x)
          (Prelude.List.unpackOptionals types.Experience.Type exps)

let intuitive_surgical = "Intuitive Surgical"

let content =
      λ(tag_list : TagList.Type) →
        let Tagged =
              λ(t : Type) →
              λ(match : ∀(tl : TagList.Type) → List Bool) →
              λ(item : t) →
                if Prelude.Bool.or (match tag_list) then Some item else None t

        let Untagged =
              λ(t : Type) →
              λ(match : ∀(tl : TagList.Type) → List Bool) →
              λ(item : t) →
                if    Prelude.List.all Bool Prelude.Bool.not (match tag_list)
                then  Some item
                else  None t

        let TaggedExperience = Tagged types.Experience.Type

        let TaggedAward = Tagged types.Award

        let TaggedText = Tagged Text

        let professional_experience =
              [ Some
                  types.Experience::{
                  , corporation = intuitive_surgical
                  , position =
                      types.Position.Single "NPI Manufacturing Engineer"
                  , dates =
                    { from = dates.monthDayYear dates.Month.August 2 2021
                    , to = dates.EndDate.Present
                    }
                  , bullets =
                    [ "Lead cross-functional team in an 8D root cause investigation to sucessful completion during product development"
                    , "Prototyped, designed, and documented fixtures \\& equipment for the assembly of tiny robotic surgical instruments"
                    , "Performed GD\\&T tolerance analysis to determine impact of assembly fits and backlash"
                    , "Created detailed engineering assemblies, components, and drawings in Solidworks"
                    , "Automated reports to analyze robotic device performance and manufacturing process capability"
                    , "Released engineering change orders in Agile PLM and CAD in Windchill PDM to get an NPI line V\\&V capable"
                    , "Lead code review and release of multiple manufacturing software updates"
                    ]
                  }
              , Some
                  types.Experience::{
                  , corporation = intuitive_surgical
                  , position =
                      types.Position.Single "Mechanical Engineering Co-op"
                  , dates =
                    { from = dates.monthDayYear dates.Month.August 12 2019
                    , to =
                        dates.EndDate.Date
                          (dates.monthDayYear dates.Month.December 18 2020)
                    }
                  , bullets =
                    [ "Performed verification and validation of engineering changes to surgical robots in the medical device industry"
                    , "Built an automated fixture using cascaded PID controllers for 8-week design verification tests"
                    , "Performed FEA and DFM on sheet metal and thermoformed plastic parts for new product development"
                    ]
                  }
              , Some
                  types.Experience::{
                  , corporation = "GTRI Brachiating Robotics"
                  , position =
                      types.Position.Progression
                        { last = "Undergraduate Assistant", first = "Intern" }
                  , dates =
                    { from = dates.monthDayYear dates.Month.April 20 2019
                    , to =
                        dates.EndDate.Date
                          (dates.monthDayYear dates.Month.July 31 2020)
                    }
                  , bullets =
                    [ "Implemented a online, optimal, robust controller in C++ on an embedded system"
                    , "Improved 4-state system ID convergence and runtime (20x, 9 hrs) using parallel computing in C++ and MATLAB"
                    , "Optimized biomimetic, robotic manipulator jaws using FEA and the compliant mechanism methodology"
                    , "Developed a novel, bi-stable linkage that improved and reduced power usage of robotic grippers"
                    , "Applied analytical machine design methodologies to size actuators and optimize chassis mass, stiffness, and cost"
                    , "LQR and SOS controller design and experimentation published in the IROS 2020 robotics conference"
                    , "Won the GT Presidential Undergraduate Research Award for outstanding research"
                    ]
                  }
              , TaggedExperience
                  (λ(tl : TagList.Type) → [ tl.full, tl.sailing ])
                  types.Experience::{
                  , corporation = "UCLA Recreation"
                  , position =
                      types.Position.Progression
                        { last = "Lead Sailing Coordinator"
                        , first = "Instructor"
                        }
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
              ]

        let main_projects =
              [ Some
                  types.Experience::{
                  , corporation = "FRC Team 971: Spartan"
                  , position = types.Position.Single "Lead Mechanical Mentor"
                  , dates =
                    { from = dates.monthDayYear dates.Month.October 24 2021
                    , to = dates.EndDate.Present
                    }
                  , bullets =
                    [ "Modeled, analyzed, and verified the oscillatory modes of a muli-DoF arm using Solidworks FEA"
                    , "Implemented Python, state-space, physics models for a robotic drivetrain with 18 states and state-of-the-art tire models"
                    , "Determined performace of path planning and full state feedback control algorithms in simulation"
                    , "Lead the 6-week hardware development sprint of a robotic system"
                    , "Managed 60 students in rapid prototyping, designing, and manufacturing a robot in six weeks"
                    , "Streamlined manufacturability, assemblability, and serviceability using Lean and Six Sigma principles"
                    , "Trained students in CAD and operating precision machinery including a mill, lathe, and CNC router"
                    ]
                  }
              , Some
                  types.Experience::{
                  , corporation = "Agricultural Robotics Lab"
                  , position = types.Position.Single "Undergraduate Researcher"
                  , dates =
                    { from = dates.monthDayYear dates.Month.August 1 2018
                    , to =
                        dates.EndDate.Date
                          (dates.monthDayYear dates.Month.April 1 2019)
                    }
                  , bullets =
                    [ "Implemented real-time sensing and pose estimation of a flexible cable for feedback control"
                    , "Processed color and depth video using OpenCV to identify small features in harsh environmental conditions"
                    , "Implemented ROS (Robot Operating System) to record, communicate, and log robot and sensor state"
                    , "Integrated stereo depth and SLAM LIDAR units into standalone hardware for brachiating robots"
                    , "Lead team of 8 students in developing experimental methods and statistical analysis"
                    ]
                  }
              , Some
                  types.Experience::{
                  , corporation = "Robojackets"
                  , position = types.Position.Single "Team Member"
                  , dates =
                    { from = dates.monthDayYear dates.Month.August 1 2016
                    , to =
                        dates.EndDate.Date
                          (dates.monthDayYear dates.Month.April 1 2017)
                    }
                  , bullets =
                    [ "Lead design of a 3lb combat robot including CAD and Design for Manufacture"
                    , "Performed FEA on weapon subsystem to prevent catastrophic and fatigue failure"
                    , "Manufactured robotic components using precision machinery including CNC mills, lathes, and waterjets"
                    , "Created autonomous path planning and motion profile algorithm using MATLAB"
                    ]
                  }
              , TaggedExperience
                  (λ(tl : TagList.Type) → [ tl.full ])
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
              , TaggedExperience
                  (λ(tl : TagList.Type) → [ tl.full ])
                  types.Experience::{
                  , corporation = "FRC Team 1836: MilkenKnights"
                  , position = types.Position.Single "Team Captain"
                  , dates =
                    { from = dates.monthDayYear dates.Month.August 1 2011
                    , to =
                        dates.EndDate.Date
                          (dates.monthDayYear dates.Month.June 1 2016)
                    }
                  , bullets =
                    [ "Managed 60 students in rapid prototyping, designing, and manufacturing a robot in six weeks"
                    , "Managed a short development time project schedule while nurturing collaboration"
                    , "Created top-down SolidWorks models of transmissions, manipulators, and complex linkages"
                    , "Implemented position PID, velocity PID, vision tracking, motion profiles, and path following"
                    , "Used Lean and Six Sigma principles to streamline manufacturing and assembly proccess"
                    , "Trained students in CAD and operating precision machinery including a mill, lathe, and CNC router"
                    ]
                  }
              , TaggedExperience
                  (λ(tl : TagList.Type) → [ tl.full ])
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
              , TaggedExperience
                  (λ(tl : TagList.Type) → [ tl.full ])
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
              ]

        let skills =
              [ { name = "Proficient"
                , skills =
                    Prelude.List.unpackOptionals
                      Text
                      [ Some "MATLAB"
                      , Some "Python"
                      , Some "C"
                      , Some "C++"
                      , Some "Julia"
                      , TaggedText
                          ( λ(tl : TagList.Type) →
                              [ tl.full, tl.machine_learning, tl.robotics ]
                          )
                          "PyTorch"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Robot Operating System~(ROS)"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.devops ])
                          "Docker"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.devops ])
                          "Terraform"
                      , TaggedText
                          ( λ(tl : TagList.Type) →
                              [ tl.full, tl.robotics, tl.vision ]
                          )
                          "OpenCV"
                      , Some "Bash"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.devops ])
                          "GNU Make"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.devops ])
                          "Packer"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.devops ])
                          "Ansible"
                      , TaggedText
                          ( λ(tl : TagList.Type) →
                              [ tl.full, tl.functional_programming ]
                          )
                          "Dhall"
                      , TaggedText
                          ( λ(tl : TagList.Type) →
                              [ tl.full, tl.machine_learning ]
                          )
                          "Machine Learning (ML)"
                      , TaggedText
                          ( λ(tl : TagList.Type) →
                              [ tl.full, tl.machine_learning ]
                          )
                          "Artificial Intelligence (AI)"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.programming ])
                          "Data Structures"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.programming ])
                          "Algorithms"
                      , Some "Git"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.programming ])
                          "Unit~Testing"
                      , Some "Code~Review"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.programming ])
                          "CI"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.programming ])
                          "CD"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.programming ])
                          "Version~Control"
                      , Some "\\LaTeX"
                      ]
                }
              , { name = "Familiar"
                , skills =
                    Prelude.List.unpackOptionals
                      Text
                      [ Some "Java"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.cloud ])
                          "Amazon Web Services~(AWS)"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.cloud ])
                          "Google Cloud"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.devops ])
                          "Kubernetes"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.cloud ])
                          "Cloud Infrastructure"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.devops ])
                          "Tooling"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "LabView"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.apps ])
                          "Android"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.webdev ])
                          "HTML"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.webdev ])
                          "CSS"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.webdev ])
                          "SASS"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.programming ])
                          "Agile"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.programming ])
                          "Architecture"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.programming ])
                          "High~Performance"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.programming ])
                          "Latency"
                      ]
                }
              , { name = "Software"
                , skills =
                    Prelude.List.unpackOptionals
                      Text
                      [ Some "Linux"
                      , Some "SolidWorks"
                      , Some "Agile PLM"
                      , Some "SAP"
                      , Some "Polarion"
                      , Some "Windchill"
                      , Some "SolidWorks Enterprise PDM~(EPDM)"
                      , Some "Autodesk Inventor"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.programming ])
                          "Jira"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.devops ])
                          "Ubuntu"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.devops ])
                          "Emacs"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.devops ])
                          "Vim"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.documentation ])
                          "Adobe Illustrator"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.documentation ])
                          "Inkscape"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.documentation ])
                          "Gimp"
                      , Some "Excel"
                      ]
                }
              , { name = "Robotics"
                , skills =
                    Prelude.List.unpackOptionals
                      Text
                      [ TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Control"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Kalman~Filter"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Model~Predictive~Control~(MPC)"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Trajectory~Optimization"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Behavior~Planning"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Motion~Planning"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Path~Planning"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Decision~Making"
                      , TaggedText
                          ( λ(tl : TagList.Type) →
                              [ tl.full, tl.robotics, tl.machine_learning ]
                          )
                          "Search"
                      , TaggedText
                          ( λ(tl : TagList.Type) →
                              [ tl.full, tl.robotics, tl.machine_learning ]
                          )
                          "Prediction"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Manipulation"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Navigation"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Real-Time"
                      , TaggedText
                          ( λ(tl : TagList.Type) →
                              [ tl.full, tl.robotics, tl.vision ]
                          )
                          "Stereo Depth Camera"
                      , TaggedText
                          ( λ(tl : TagList.Type) →
                              [ tl.full, tl.robotics, tl.vision ]
                          )
                          "SLAM LIDAR"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "CAN"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "ARM"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "NI~cRio/myRio/roboRio"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Festo Actuators and Drives"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Raspberry Pi"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Arduino"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Brushless Servos"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Brushed Servos"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Direct~Drive"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Harmonic~Drive"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Pneumatic~Actuators"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Motors"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Encoders"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Solenoids"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Mechatronics"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Electro-mechanical"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.sensor ])
                          "Hall~Effect"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.sensor ])
                          "IR~Sensors"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.sensor ])
                          "Sonar"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.sensor ])
                          "Sensors"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Autonomous"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Uncertainty"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.robotics ])
                          "Probability~Theory"
                      ]
                }
              , { name = "3D CAD"
                , skills =
                    Prelude.List.unpackOptionals
                      Text
                      [ TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.cad ])
                          "Master Model"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.cad ])
                          "Top-down Design"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.cad ])
                          "Parametric Design"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.cad ])
                          "Surface Modeling"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.cad ])
                          "2D~\\&~3D Manufacturing/Installation Drawings"
                      , Some "Geometric Design~\\& Tolerancing"
                      , Some "Design for Manufacture~(DFM)"
                      , Some "Design for Assembly~(DFA)"
                      , Some "Finite Element Analysis~(FEA)"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.mechanical ])
                          "Simulation"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.mechanical ])
                          "3D Modeling"
                      ]
                }
              , { name = "Fabrication"
                , skills =
                    Prelude.List.unpackOptionals
                      Text
                      (   [ Some "Rapid Developemnt"
                          , Some "Prototyping"
                          , Some "G-Code"
                          , Some "CNC Mill"
                          , Some "Manual Mill"
                          , Some "Manual Lathe"
                          , Some "Laser Cutter"
                          , Some "Waterjet"
                          , Some "3D Printer"
                          ]
                        # Prelude.List.map
                            Text
                            (Optional Text)
                            ( λ(item : Text) →
                                TaggedText
                                  ( λ(tl : TagList.Type) →
                                      [ tl.full, tl.manufacturing ]
                                  )
                                  item
                            )
                            [ "Selective Laser Sintering~(SLS)"
                            , "Drill Press"
                            , "Bandsaw"
                            , "Soldering Iron"
                            , "Sheet Metal"
                            , "Casting"
                            , "Molding"
                            , "Manufacturing Proccesses"
                            , "Machining"
                            ]
                      )
                }
              , { name = "Instruments"
                , skills =
                    Prelude.List.unpackOptionals
                      Text
                      ( Prelude.List.map
                          Text
                          (Optional Text)
                          ( λ(item : Text) →
                              TaggedText
                                ( λ(tl : TagList.Type) →
                                    [ tl.full, tl.instruments ]
                                )
                                item
                          )
                          [ "Micrometer"
                          , "Caliper"
                          , "Ocilloscope"
                          , "Multimeter"
                          , "Voltmeter"
                          ]
                      )
                }
              , { name = "Process"
                , skills =
                    Prelude.List.unpackOptionals
                      Text
                      [ Some "Investigation"
                      , Some "Design Review"
                      , Some "Failure Mode \\& Effects Analysis~(FMEA)"
                      , Some "Root Cause Analysis"
                      , Some "Statistics"
                      , Some "Project Management"
                      , TaggedText
                          ( λ(tl : TagList.Type) →
                              [ tl.full, tl.problem_solving ]
                          )
                          "First Principles"
                      , TaggedText
                          ( λ(tl : TagList.Type) →
                              [ tl.full, tl.problem_solving ]
                          )
                          "Problem Solving"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.manufacturing ])
                          "Lean Manufacturing"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.manufacturing ])
                          "Six Sigma"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.planning ])
                          "8D"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.planning ])
                          "5-Whys"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.planning ])
                          "DMAIC"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.planning ])
                          "Planning"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.planning ])
                          "Customer Expectations"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.planning ])
                          "Project Schedule"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.planning ])
                          "Product Cycle"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.planning ])
                          "Feature Definition"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.creative ])
                          "Creative"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.creative ])
                          "Innovative"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.communication ])
                          "Collaborative"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.communication ])
                          "Cooperative"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.communication ])
                          "Team Environment"
                      , TaggedText
                          ( λ(tl : TagList.Type) →
                              [ tl.full, tl.communication, tl.problem_solving ]
                          )
                          "Independent"
                      , TaggedText
                          ( λ(tl : TagList.Type) →
                              [ tl.full, tl.communication, tl.problem_solving ]
                          )
                          "Learning"
                      , TaggedText
                          ( λ(tl : TagList.Type) →
                              [ tl.full, tl.problem_solving ]
                          )
                          "Debugging"
                      , TaggedText
                          ( λ(tl : TagList.Type) →
                              [ tl.full, tl.problem_solving ]
                          )
                          "Troubleshooting"
                      , TaggedText
                          ( λ(tl : TagList.Type) →
                              [ tl.full, tl.conflict_resolution ]
                          )
                          "Negotiation"
                      , TaggedText
                          ( λ(tl : TagList.Type) →
                              [ tl.full, tl.conflict_resolution ]
                          )
                          "Conflict Mangement"
                      , TaggedText
                          ( λ(tl : TagList.Type) →
                              [ tl.full, tl.conflict_resolution ]
                          )
                          "Conflict Resolution"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.communication ])
                          "Verbal Communication"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.communication ])
                          "Written Communication"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.reports ])
                          "Oral Reports"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.reports ])
                          "Technical Reports"
                      , Some "Documentation"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.documentation ])
                          "Engineering Change Order~(ECO)"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.reports ])
                          "Executive Summaries"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.reports ])
                          "Progress Reports"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.chart ])
                          "Bill of Materials~(BOM)"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.chart ])
                          "House of Quality"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.chart ])
                          "Specification Sheet"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.chart ])
                          "Morph Chart"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.chart ])
                          "Function Tree"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.chart ])
                          "Gantt Chart"
                      , TaggedText
                          (λ(tl : TagList.Type) → [ tl.full, tl.chart ])
                          "Evaulation Matrix"
                      ]
                }
              ]

        let awards =
              Prelude.List.unpackOptionals
                types.Award
                [ Some
                    ( toFIRSTAward
                        { event = FIRSTEvent.Regional "Monterey Bay"
                        , date = "April 2023"
                        , place = 2
                        , team_count = 36
                        }
                    )
                , Some
                    ( toFIRSTAward
                        { event = FIRSTEvent.Regional "San Francisco"
                        , date = "Mar 2023"
                        , place = 1
                        , team_count = 42
                        }
                    )
                , Some
                    ( toFIRSTAward
                        { event = FIRSTEvent.ChampionshipDivision "Turing"
                        , date = "April 2022"
                        , place = 2
                        , team_count = 75
                        }
                    )
                , Some
                    ( toFIRSTAward
                        { event = FIRSTEvent.Regional "Silcon Valley"
                        , date = "April 2022"
                        , place = 2
                        , team_count = 59
                        }
                    )
                , Some
                    ( toFIRSTAward
                        { event = FIRSTEvent.Regional "Monterey Bay"
                        , date = "April 2023"
                        , place = 2
                        , team_count = 36
                        }
                    )
                , Some
                    ( toFIRSTAward
                        { event = FIRSTEvent.Regional "San Francisco"
                        , date = "Mar 2022"
                        , place = 2
                        , team_count = 41
                        }
                    )
                , Some
                    ( types.Award.TimePeriod
                        { name = "Georgia Tech Dean's List"
                        , from = "Dec 2016"
                        , to = "to May 2021"
                        }
                    )
                , Some
                    ( types.Award.Placed
                        { name =
                            "S. Farzan, A. Hu, M. Bick and J. Rogers, \"Robust Control Synthesis and Verification for Wire-Borne Underactuated Brachiating Robots Using Sum-of-Squares Optimization,\" \\emph{2020 IEEE/RSJ International Conference on Intelligent Robots and Systems (IROS)}."
                        , date = "Oct 2020"
                        , place = ""
                        }
                    )
                , Some
                    ( types.Award.Placed
                        { name =
                            "GT Presidential Undergraduate Research Award (PURA)"
                        , date = "April 2020"
                        , place = ""
                        }
                    )
                , Some
                    ( types.Award.Placed
                        { name = "Georgia Tech ME2110 Design Competition"
                        , date = "Nov 2017"
                        , place = "\\nth{7}/60"
                        }
                    )
                , Some
                    ( toFIRSTAward
                        { event = FIRSTEvent.Regional "Orange County"
                        , date = "Apr 2016"
                        , place = 2
                        , team_count = 42
                        }
                    )
                , Some
                    ( toFIRSTAward
                        { event = FIRSTEvent.Regional "Ventura"
                        , date = "Mar 2015"
                        , place = 3
                        , team_count = 41
                        }
                    )
                , Some
                    ( toFIRSTAward
                        { event = FIRSTEvent.Regional "Utah"
                        , date = "Mar 2015"
                        , place = 3
                        , team_count = 53
                        }
                    )
                , TaggedAward
                    (λ(tl : TagList.Type) → [ tl.full ])
                    ( types.Award.Placed
                        { name = "Conrad Spirit of Innovation Semi-Finalist"
                        , date = "Oct 2014"
                        , place = "International"
                        }
                    )
                , TaggedAward
                    (λ(tl : TagList.Type) → [ tl.full ])
                    ( toFIRSTAward
                        { event = FIRSTEvent.Regional "Los Angeles"
                        , date = "Mar 2013"
                        , place = 1
                        , team_count = 65
                        }
                    )
                , TaggedAward
                    (λ(tl : TagList.Type) → [ tl.full ])
                    ( toFIRSTAward
                        { event = FIRSTEvent.Regional "Los Angeles"
                        , date = "Mar 2012"
                        , place = 2
                        , team_count = 66
                        }
                    )
                ]

        in  [ { title = "Professional Experience"
              , data = toSectionItems professional_experience
              }
            , { title = "Education", data = education }
            , { title = "Technical Leadership Projects"
              , data =
                    toSectionItems main_projects
                  # [ types.SectionItem.Projects side_projects ]
              }
            , { title = "Publications, Awards, \\& Honors"
              , data = [ types.SectionItem.Awards awards ]
              }
            , { title = "Technical Skills"
              , data =
                [ types.SectionItem.Skills
                    { groups = skills, longest_group_title = "Fabrication" }
                ]
              }
            ]

in  { content, TagList }
