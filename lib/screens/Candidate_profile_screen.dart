import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:nanirecruitment/constants.dart';
import 'dart:convert';

import '../services/api_urls.dart';

class CandidateProfileScreen extends StatefulWidget {
  CandidateProfileScreen(this.candidate_id);
  final String? candidate_id;

  @override
  _CandidateProfileScreenState createState() => _CandidateProfileScreenState();
  static const routeName = '/candidate-profile-screen';
}

class _CandidateProfileScreenState extends State<CandidateProfileScreen> {
  late Map<String, dynamic> candidateData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCandidateProfile();
  }

  Future<void> fetchCandidateProfile() async {
    var response = await http.post(
      Uri.parse('${ApiUrls.BASE_URL}client_app/candidate_profile_by_id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'candidate_id': widget.candidate_id.toString(),
        // Replace with actual candidate ID
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        var data = json.decode(response.body);
        if (data is List && data.isNotEmpty) {
          print('the data is $data');
          candidateData =
              data.first; // Assuming you want the first element of the list
          isLoading = false;
        } else {
          // Handle unexpected data format
        }
      });
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // This provides the total height and width of the screen

    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        centerTitle: true,
        backgroundColor: bggcolor,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height * 0.02),
              CircleAvatar(
                backgroundImage: NetworkImage(candidateData['ppicture'] ?? 'assets/default_avatar.png'),
                radius: size.width * 0.2, // Responsive width for the profile image
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                '${candidateData['fname']} ${candidateData['mname']} ${candidateData['lname']}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: bggcolor,
                ),
              ),

              Text(
                candidateData['title'] ?? 'No Title Provided',
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Divider(),
              InfoCard(
                icon: Icons.email,
                content: candidateData['email'] ?? 'No Email Provided',
              ),
              // InfoCard(
              //   icon: Icons.person,
              //   content: candidateData['gender'] ?? 'No Gender Provided',
              // ),
              InfoCard(
                icon: Icons.phone,
                content: candidateData['mobile'] ?? 'No Mobile Provided',
              ),
              InfoCard(
                icon: Icons.location_on,
                content: candidateData['location'] ?? 'No Location Provided',
              ),
              InfoCard(
                icon: Icons.language,
                content: candidateData['Languages'] ?? 'No Languages Provided',
              ),


              // Description Section
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  candidateData['Description'] ?? 'No Description Provided',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: txtcolor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),

              // Footer with additional meaningful data
              buildFooterSection(context),

              SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFooterSection(BuildContext context) {
    // Format dates using the intl package for better readability
    String creationDate = candidateData['Creation_date'] ?? 'Not Provided';
    String formattedCreationDate = DateFormat('MMM d, yyyy').format(DateTime.parse(creationDate));

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            'Additional Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: bggcolor,
            ),
          ),
          Divider(),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              footerInfoItem(Icons.calendar_today, 'Member since: $formattedCreationDate'),
              customDivider(),
              footerInfoItem(Icons.check_circle_outline, 'Active Status: ${candidateData['status'] ?? 'Not Provided'}'),
            ],
          )

          // Add more relevant data as needed
        ],
      ),
    );
  }
  Widget customDivider() {
    return Container(
      height: 20,
      child: VerticalDivider(color: txtcolor, thickness: 2),
      margin: EdgeInsets.symmetric(horizontal: 10),
    );
  }

  Widget footerInfoItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, color: txtcolor, size: 20),
          SizedBox(width: 8),
          Text(text, style: TextStyle(fontSize: 16, color: txtcolor)),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String content;

  const InfoCard({
    Key? key,
    required this.icon,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListTile(
        leading: Icon(icon, color: txtcolor),
        title: Text(content),
      ),
    );
  }
}






