class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question({required this.id, required this.question, required this.answer, required this.options});
}

const List sample_data = [
{
"id": 1,
"question": "Which part of the eye is responsible for controlling the amount of light that enters?",
"options": ["Cornea", "Pupil", "Iris", "Retina"],
"answer_index": 2
},

{
"id": 2,
"question": "What is the medical term for nearsightedness?",
"options": ["Hyperopia", "Astigmatism", "Presbyopia", "Myopia"],
"answer_index": 3
},

{
"id": 3,
"question": "What part of the eye is commonly known as the 'white of the eye'?",
"options": ["Iris", "Sclera", "Pupil", "Cornea"],
"answer_index": 1
},

{
"id": 4,
"question": "Which condition is characterized by the clouding of the eye's natural lens?",
"options": ["Glaucoma", "Cataracts", "MacularDegeneration", "Conjunctivitis"],
"answer_index": 1
},

{
"id": 5,
"question": "What is the name of the transparent, curved structure at the front of the eye?",
"options": ["Iris", "Sclera", "Pupil", "Cornea"],
"answer_index": 3
},

{
"id": 6,
"question": "What is the medical term for the condition commonly known as 'lazy eye'?",
"options": ["Strabismus", "Amblyopia", "Myopia", "Astigmatism"],
"answer_index": 1
},

{
"id": 7,
"question": "What is the part of the eye that contains the cells responsible for detecting light and color?",
"options": ["Pupil", "Lens", "Retina", "Cornea"],
"answer_index": 2
},

{
"id": 8,
"question": "Which eye condition is often caused by increased pressure within the eye?",
"options": ["Glaucoma", "Cataracts", "MacularDegeneration", "Conjunctivitis"],
"answer_index": 0
},

{
"id": 9,
"question": "What is the name of the circular, colored part of the eye that surrounds the pupil?",
"options": ["Iris", "Sclera", "Lens", "Cornea"],
"answer_index": 0
},

  {
    "id": 10,
    "question": "Which eye condition is characterized by the loss of central vision?",
    "options": [
      "Glaucoma",
      "Cataracts",
      "MacularDegeneration",
      "Conjunctivitis"
    ],
    "answer_index": 2
  },
];