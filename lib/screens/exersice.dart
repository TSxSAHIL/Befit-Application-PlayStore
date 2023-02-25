

// ignore_for_file: use_key_in_widget_constructors, unused_import

import 'package:befit/constants/app_constants.dart';
import 'package:befit/main.dart';
import 'package:flutter/material.dart';

class ExpansionTileExample extends StatelessWidget {
  const ExpansionTileExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainHexColor,
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              EntryItem(data[index]),
          itemCount: data.length,
        ),
      ),
    );
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  const Entry(this.title, [this.children = const <Entry>[]]);
  final String title;
  final List<Entry> children;
}

// Data to display.
const List<Entry> data = <Entry>[
  Entry(
    'Chest',
    <Entry>[
      Entry(
        ' Upper Chest',
        <Entry>[
          Entry('   Incline Barbell Bench Press'),
          Entry('   Incline Dumbbell Press'),
          Entry('   Incline Cable Fly'),
          Entry('   Incline Dumbbell Flies'),
          Entry('   Incline Pushups')
        ],
      ),
      Entry(
        ' Lower Chest',
        <Entry>[
          Entry('   Decline Barbell Bench Press'),
          Entry('   Decline Dumbbell Press'),
          Entry('   Decline Cable Fly'),
          Entry('   Decline Dumbbell Flies'),
          Entry('   Decline Pushups'),
        ],
      ),
      Entry(
        ' Mid Chest',
        <Entry>[
          Entry('   Flat Barbell Bench Press'),
          Entry('   Flat Dumbbell Press'),
          Entry('   Cable Fly'),
          Entry('   Dumbbell Flies'),
          Entry('   Flat Pushups'),
          Entry('   Dumbbell Pullover'),
        ],
      ),
    ],
  ),
  Entry(
    'Back',
    <Entry>[
      Entry('   Lats',
      <Entry>[
        Entry('     Lat Pulldown'),
        Entry('     Lat PullOver'),
        Entry('     Single Arm Lat PullDown'),
        Entry('     Pull Ups'),
        Entry('     T-Bar Rows'),
        Entry('     Dumbbell Rows'),
      ]
      ),
      Entry('   Upper Back' ,
      <Entry>[
        Entry('     Bent Over Barbell Row'),
        Entry('     High Pulls'),
        Entry('     Seal Rows'),
        Entry('     Face Pulls'),
        Entry('     Barbell Shrugs'),
        Entry('     Dumbbell Shrugs'),
      ]
      ),
      Entry('   Mid Back' ,
      <Entry>[
        Entry('     Incline Dumbbell Rows'),
        Entry('     Seated Rows'),
        Entry('     Wide Grip Seated Rows'),
        Entry('     HyperExtensions'),
        Entry('     T-Bar Rows with Handle')
      ]
      ),
      Entry('   Lower Back' ,
      <Entry>[
        Entry('     Deadlifts'),
        Entry('     Rack Pulls'),
        Entry('     Good Mornings'),
        Entry('     Back Extensions'),
        Entry('     Russian Twists'),
        Entry('     Lower Back Rotation')
      ]
      ),
    ],
  ),
  Entry(
    'Shoulders',
    <Entry>[
      Entry('   Front Deltoid',
      <Entry>[
        Entry('     Overhead Press'),
        Entry('     Dumbbell Shoulder Press'),
        Entry('     Front Raises'),
        Entry('     Arnold Press'),
        Entry('     Upright Rows'),
      ]
      ),
      Entry('   Lateral Deltoid',
      <Entry>[
        Entry('     Dumbbell Side Lateral Raises'),
        Entry('     One Arm Cable Raises'),
        Entry('     Behind the Back Cable Raises'),
        Entry('     Incline Side Lateral Raises')
      ]
      ),
      Entry('   Rear Delts',
      <Entry>[
        Entry('     Face Pulls'),
        Entry('     Reverse Pec Delts'),
        Entry('     Standing Bent over Lateral Raises'),
        Entry('     Pendlay Rows')
      ]
      ),
    ],
  ),
  Entry(
    'Legs',
    <Entry>[
      Entry('   Quads',
      <Entry>[
        Entry('     Squats'),
        Entry('     Leg Extensions'),
        Entry('     Leg Press')
      ]
      ),
      Entry('   Glutes',
      <Entry>[
        Entry('     Hip Thrusts'),
        Entry('     Bridges'),
        Entry('     Donkey Kick Backs'),
        Entry('     Lunges')
      ]
      ),
      Entry('   Hamstring',
      <Entry>[
        Entry('     Romanian Deadlifts'),
        Entry('     Leg Curls'),
        Entry('     Bulgarian Split Squats')
      ]
      ),
      Entry('   Calf',
      <Entry>[
        Entry('     Calf Raises'),
        Entry("     Farmer's Walk")
      ]
      ),
    ],
  ),
  Entry('Biceps',
  <Entry>[
    Entry('   Short Head',
    <Entry>[
      Entry('     Preacher Curls'),
      Entry('     Wide Grip Curls'),
      Entry('     Spider Curls'),
      Entry('     Concentration Curls'),
      Entry('     Inner Bicep Curls'),
      Entry('     Incline Dumbbell Curls'),
    ]
    ),
    Entry('   Long Head',
    <Entry>[
      Entry('     Close Grip Barbell Curls'),
      Entry('     Close Grip Preacher Curls'),
      Entry('     Dumbbell Hammer Curls'),
      Entry('     EZ Barbell Curls'),
      Entry('     Cable Hammer Curls'),
      Entry('     Cable Bicep Curls'),
    ]
    ),
  ]
  ),
  Entry('Triceps',
  <Entry>[
    Entry('   Medial & Lateral Head',
    <Entry>[
      Entry('     Close-Grip Bench Press'),
      Entry('     Skullcrushers'),
      Entry('     Diamond Push-Ups'),
      Entry('     Tricep Push Downs')
    ]
    ),
    Entry('  Long Head',
    <Entry>[
      Entry('     Dumbbell Tricep Kickbacks'),
      Entry('     Pushdowns'),
      Entry('     Overhead Tricep Extensions'),
      Entry('     Rope PushDowns')
    ]
    )
  ]
  ),
  Entry('Abs',
  <Entry>[
    Entry(' Upper Abs',
    <Entry>[
      Entry('     Bicycle Crunch'),
      Entry('     Plank to Toe Touch'),
      Entry('     Toe Reach'),
      Entry('     Crunches')
    ]
    ),
    Entry(' Lower Abs',
    <Entry>[
      Entry('     Ab Contractions'),
      Entry('     Leg Drops'),
      Entry('     Hip Lift'),
      Entry('     Boat Pose'),
      Entry('     Mountain Climbers'),
    ]
    )
  ]
  )
];
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: mainHexColor,
        child: ExpansionTile(
          
          key: PageStorageKey<Entry>(root),
          title: Text(root.title),
          children: root.children.map(_buildTiles).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}