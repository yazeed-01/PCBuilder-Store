import 'package:flutter/material.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
        actions: [
          IconButton(
            icon: const Icon(Icons.question_answer),
            tooltip: 'Q&A',
            onPressed: () {
              setState(() {
                _selectedIndex = 0; 
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.book),
            tooltip: 'Guides',
            onPressed: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
          ),
        ],
      ),
      body: Row(
        children: [
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                QuestionsAnswersPage(),
                GuidesPage(),
                TroubleshootingPage(),
                FAQsPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionsAnswersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            title: Text('Question ${index + 1}'),
            subtitle: Text('Asked by User${index + 1}'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      QuestionDetailPage(questionId: index + 1),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class QuestionDetailPage extends StatelessWidget {
  final int questionId;

  const QuestionDetailPage({Key? key, required this.questionId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample data
    final question = {
      'title': 'How do I upgrade my PC\'s RAM?',
      'body':
          'I want to upgrade my PC\'s RAM but I\'m not sure how to do it. Can someone help me with the steps?',
      'askedBy': 'User1',
      'answers': [
        {
          'body':
              'Here are the steps to upgrade your RAM:\n1. Shut down your PC and unplug it.\n2. Open the case.\n3. Locate the RAM slots.\n4. Remove the old RAM sticks.\n5. Insert the new RAM sticks.\n6. Close the case and plug in your PC.\n7. Turn on your PC and check if the new RAM is recognized.',
          'answeredBy': 'TechExpert',
          'isCorrect': true,
        },
        {
          'body':
              'Make sure to check your motherboard manual for compatible RAM types and speeds before purchasing new RAM.',
          'answeredBy': 'PCEnthusiast',
          'isCorrect': false,
        },
      ],
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Question $questionId'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question['title'] as String,
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Asked by: ${question['askedBy']}',
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 16),
            Text(question['body'] as String),
            const SizedBox(height: 24),
            Text('Answers', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            ...(question['answers'] as List).map((answer) => Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Answered by: ${answer['answeredBy']}',
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow
                              .ellipsis, // Handle overflow gracefully
                        ),
                        if (answer['isCorrect'] as bool)
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Chip(
                              label: Text('Correct Answer'),
                              backgroundColor: Colors.green,
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        const SizedBox(height: 8),
                        Text(answer['body'] as String),
                      ],
                    ),
                  ),
                )),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement add answer functionality
              },
              child: const Text('Add Your Answer'),
            ),
          ],
        ),
      ),
    );
  }
}

class GuidesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Guide ${index + 1}'),
          subtitle: Text('Description of Guide ${index + 1}'),
          onTap: () {
            // TODO: Navigate to full guide
          },
        );
      },
    );
  }
}

class TroubleshootingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return ExpansionTile(
          title: Text('Issue ${index + 1}'),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Steps to resolve Issue ${index + 1}'),
            ),
          ],
        );
      },
    );
  }
}

class FAQsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return ExpansionTile(
          title: Text('FAQ ${index + 1}'),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Answer to FAQ ${index + 1}'),
            ),
          ],
        );
      },
    );
  }
}
