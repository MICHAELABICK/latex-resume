let Prelude = ./Prelude.dhall

let Tags =
      { Type = { old : Bool, webdev : Bool }
      , default = { old = False, webdev = False }
      }

let matchTags
    : Tags.Type → Bool
    = λ(tags : Tags.Type) →
        Prelude.Bool.not tags.old && Prelude.Bool.not tags.webdev

let types = ./types.dhall Tags.Type

let tagItem = λ(Item : Type) → λ(item : Item) → { item, tags = Tags.default }

let TaggedExperience
    : types.Experience.Type → types.Tagged.Type types.Experience.Type
    = tagItem types.Experience.Type

let TaggedText
    : Text → types.Tagged.Type Text
    = types.Tagged.tagText Tags.default

let content =
      [ { title = "Education"
        , data =
            types.SectionData.Education
              { gpa = 3.60
              , name = "Georgia Institute of Technology"
              , location = "Atlanta, GA"
              , dates = { from = "Aug 2016", to = "June 2020" }
              , major = "Bachelors of Science: Mechanical Engineering"
              , minor = Some "Robotics"
              , graduated = False
              , awards =
                  "Studied abroad at Georgia Tech Lorraine in Metz, France"
              }
        }
      , { title = "Work Experience"
        , data =
            types.SectionData.Experiences
              [ TaggedExperience
                  types.Experience::{
                  , corporation = "UCLA Recreation"
                  , position = Some "Lead Sailing Coordinator"
                  , dates = { from = "June 2016", to = "Aug 2018" }
                  , bullets =
                    [ "Coordinated the daily plan and goals for 20 co-workers"
                    , "Responsible for safety of UCLA sailors on and off the water"
                    , "Taught sailors with skill levels ranging from beginner to advanced"
                    , "Advanced from instructor to lead coordinator"
                    ]
                  }
              ]
        }
      , { title = "Academic Leadership Projects"
        , data =
            types.SectionData.Experiences
              [ TaggedExperience
                  types.Experience::{
                  , corporation = "GTRI Agricultural Robotics"
                  , position = Some "Undergraduate Researcher"
                  , dates = { from = "Aug 2018", to = "April 2019" }
                  , bullets =
                    [ "Researched, integrated, and programmed stereo depth and SLAM LIDAR units for brachiating robot"
                    , "Processed color and depth video using openCV to identify a thin cable in harsh environmental conditions"
                    , "Implemented ROS (Robot Operating System) to record, communicate, and log robot and sensor state"
                    , "Developing a standalone cable-pose sensor for feedback controls of a robot and flexible cable system"
                    ]
                  }
              , TaggedExperience
                  types.Experience::{
                  , corporation = "Robojackets"
                  , position = Some "Team Member"
                  , dates = { from = "Aug 2016", to = "April 2017" }
                  , bullets =
                    [ "Lead design of a 3lb combat robot including CAD and Design for Manufacture"
                    , "Performed Finite Element Analysis on weapon subsystem to prevent catastrophic and fatigue failure"
                    , "Manufactured robotic components using precision machinery including CNC mills, lathes, and waterjets"
                    , "Created autonomous path planning and motion profile algorithm using MATLAB"
                    ]
                  }
              , TaggedExperience
                  types.Experience::{
                  , corporation = "GT Motorsports"
                  , position = Some "Powertrain Team Member"
                  , dates = { from = "Aug 2016", to = "April 2017" }
                  , bullets =
                    [ "Simulated engine dynamics to increase efficiency and low-end torque by lowering power-band"
                    , "Designed improved camshaft to match optimal lift profile"
                    ]
                  }
              , TaggedExperience
                  types.Experience::{
                  , corporation = "MilkenKnights FRC Team"
                  , position = Some "Team Captain"
                  , dates = { from = "Aug 2011", to = "Jun 2016" }
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
                  , dates = { from = "Aug 2016", to = "Dec 2016" }
                  , bullets =
                    [ "Surface modeled an X-Wing, designed to be SLS printed to minimize part count and ease assembly"
                    , "Performed Geometric Dimensioning and Tolerancing to ensure functionality"
                    , "Created manufacturing drawings, assembly diagrams, and sections views for a technical report"
                    , "Final print is used as an example of excellent modeling technique and novel usage of SLS 3D printing"
                    ]
                  }
              , TaggedExperience
                  types.Experience::{
                  , corporation = "Creative Decisions and Design Competition"
                  , dates = { from = "Aug 2017", to = "Dec 2017" }
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
                    , position = Some "Mechatronics Lead"
                    , dates = { from = "Sep 2014", to = "Jun 2015" }
                    , bullets =
                      [ "Designed a belt than warned the visually-impaired of hazardous obstacles"
                      , "Wired and programmed a LIDAR tracking system using an Arduino microcontroller"
                      ]
                    }
                ⫽ { tags = Tags::{ old = True } }
              ,   TaggedExperience
                    types.Experience::{
                    , corporation = "Edge Systems Design"
                    , position = Some "Mechanical Engineer"
                    , dates = { from = "Jun 2012", to = "Jun 2014" }
                    , bullets =
                      [ "Designed base frame and linear motion system for an affordable CNC router"
                      , "Helped manage funding and operation of a startup"
                      ]
                    }
                ⫽ { tags = Tags::{ old = True } }
              ]
        }
      , { title = "Technical Skills"
        , data =
            types.SectionData.Skills
              { groups =
                [ { name = "CAD"
                  , skills =
                    [ TaggedText "Solidworks~(8 years)"
                    , TaggedText "Autodesk Inventor~(9 years)"
                    , TaggedText "Master Model"
                    , TaggedText "Top-down Design"
                    , TaggedText "Parametric Design"
                    , TaggedText "Surface Modeling"
                    , TaggedText "2D~\\&~3D Manufacturing/Installation Drawings"
                    , TaggedText "Geometric Design~\\& Tolerancing"
                    , TaggedText "Design for Manufacture~(DFM)"
                    , TaggedText "Design for Assembly~(DFA)"
                    , TaggedText "Finite Element Analysis~(FEA)"
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
                    , TaggedText "Java"
                    , TaggedText "Python"
                    , TaggedText "Git"
                    , TaggedText "Bash"
                    , TaggedText "Robot Operating System~(ROS)"
                    , TaggedText "OpenCV"
                    , TaggedText "LabView"
                    , TaggedText "Android"
                    , TaggedText "HTML"
                      // { tags = Tags::{ webdev = True } }
                    , TaggedText "CSS"
                      // { tags = Tags::{ webdev = True } }
                    , TaggedText "SASS"
                      // { tags = Tags::{ webdev = True } }
                    , TaggedText "\\LaTeX"
                    ]
                  }
                , { name = "Mechatronics"
                  , skills =
                      [ TaggedText "NI~cRio/myRio/roboRio"
                      , TaggedText "Arduino"
                      , TaggedText "Servo Motors"
                      , TaggedText "Intel~Realsense Stereo~Camera"
                      , TaggedText "SLAM LIDAR"
                      , TaggedText "Sonar"
                      , TaggedText "Hall~Effect"
                      , TaggedText "Pneumatic Actuators"
                      , TaggedText "Encoders"
                      , TaggedText "Solenoids"
                      , TaggedText "IR~Sensors"
                      , TaggedText "Wire Harness"
                      ]
                  }
                , { name = "Software"
                  , skills =
                      [
                      , TaggedText "Adobe Illustrator"
                      , TaggedText "Linux"
                      , TaggedText "Ubuntu"
                      , TaggedText "Emacs"
                      , TaggedText "Vim"
                      , TaggedText "Inkscape"
                      , TaggedText "Gimp"
                      , TaggedText "Excel"
                      , TaggedText "Word"
                      , TaggedText "MacOS"
                      , TaggedText "Windows"
                      ]
                  }
                , { name = "Instruments"
                  , skills =
                      [
                      , TaggedText "Micrometer"
                      , TaggedText "Caliper"
                      , TaggedText "Ocilloscope"
                      , TaggedText "Multimeter"
                      ]
                  }
                , { name = "Communication"
                  , skills =
                      [ TaggedText "Oral Reports"
                      , TaggedText "Technical Reports"
                      , TaggedText "Documentation"
                      , TaggedText "Executive Summaries"
                      , TaggedText "Progress Reports"
                      , TaggedText "Bill of Materials~(BOM)"
                      ]
                  }
                , { name = "Planning"
                  , skills =
                      [
                      , TaggedText "House of Quality"
                      , TaggedText "Specification Sheet"
                      , TaggedText "Morph Chart"
                      , TaggedText "Function Tree"
                      , TaggedText "Gantt Chart"
                      , TaggedText "Evaulation Matrix"
                      ]
                  }
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

in
{
, content = content
, Tags = Tags.Type
, matchTags = matchTags
}
