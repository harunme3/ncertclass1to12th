import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  PrivacyPolicy();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy',
            style: Theme.of(context).primaryTextTheme.bodyText1),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 24.0, bottom: 24.0, left: 18.0, right: 14.0),
                child: Container(
                  child: RichText(
                      text: TextSpan(
                          style: Theme.of(context).primaryTextTheme.bodyText1,
                          children: [
                        TextSpan(
                            text: 'Privacy Policy\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '''
This page is used to inform visitors regarding our policies with the collection, use, and disclosure of Personal Information if anyone decided to use our Service.

If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.
''',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              )
                            ]),
                        TextSpan(
                            text: 'Photos/Media\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '''
This permission allows this application to save PDFs in storage

''',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              )
                            ]),
                        TextSpan(
                            text: 'Storage\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '''
This permission allows this application to save PDFs in storage.
''',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              )
                            ]),
                        TextSpan(
                            text: 'Internet/Access Network State\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '''
Our applications use INTERNET and ACCESS_NETWORK_STATE permissions for communicating from our application servers. Access network state is for check the network Connection status and observes the on/off of Network state.

''',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              )
                            ]),
                        TextSpan(
                            text: 'User-Provided Informationn',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '''
The Application obtains the information you provide when you register on the Application. When you register with us and use the Application, you generally provide your name, email address, phone number and address.

''',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              )
                            ]),
                        TextSpan(
                            text: 'Automatically Collected Information\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '''
This app does not automatically collect any personal information.
''',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              )
                            ]),
                        TextSpan(
                            text: 'Information Collected and Use\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '''
This Application does not require any personal information other than third-party services that may collect information used to identify you.

Link to the privacy policy of third party service providers used by the app:-
''',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              )
                            ]),
                        TextSpan(
                            text: 'Firebase Messaging:-\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '''
We use FireBase Messaging for Notification. You can read their Privacy Policy here.
''',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              )
                            ]),
                        TextSpan(
                            text: 'Admob:-\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '''
To be able to offer you our services for free, we show third party ads within your mobile apps through Admob. For Additional Information about Admob policies please refer to the below link:- https://policies.google.com/privacy?hl=en

Additional links of Google Admob for more information:-

https://support.google.com/admob/answer/2753860#Interest_based

https://support.google.com/admob/answer/9012903?hl=en-GB

Data of our mobile users remain anonymous to us and to third party ad agencies. However, the ad agencies’ SDK code will collect data to tailor ads to you, such as the third-party apps you installed on your device, your Android advertising identifier, your IP Address, your device's operating system details and MAC address, and other statistical and technical information.

AdMob may use the devices advertising id to serve personalized ads based on the user's interests (which includes collecting and analyzing user data)You can opt-out using this link-  Google link for opt-out Ad personalisation

''',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              )
                            ]),
                        TextSpan(
                            text: 'Log Data\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '''
We want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.

''',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              )
                            ]),
                        TextSpan(
                            text: 'Cookies\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '''
Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.

This Service does not use these “cookies” explicitly. However, the app may use third party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.

Service Providers

We may employ third-party companies and individuals due to the following reasons:

To facilitate our Service;

To provide the Service on our behalf;

To perform Service-related services; or

To assist us in analyzing how our Service is used.

We want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.

''',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              )
                            ]),
                        TextSpan(
                            text: 'Disclaimer\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '''
We are not the official partner of the Government or linked in any way with the government. We just provide information to the user which is available in the public domain. All the information and website links are available in the public domain and can be used by users. We do not own any website available in-app. Application is developed as a public service to help Indian residents to find and manage their digital service in their area. People use app for personal information purpose only. Application is not affiliated with any government services or person.

''',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              )
                            ]),
                        TextSpan(
                            text: 'Security\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '''
We value your trust in providing us with your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.

''',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              )
                            ]),
                        TextSpan(
                            text: 'Links to Other Sites\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '''
This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites. We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.

''',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              )
                            ]),
                        TextSpan(
                            text: 'Children’s Privacy\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '''
These Services do not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13. In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to do the necessary actions.
''',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              )
                            ]),
                        TextSpan(
                            text: 'Changes to This Privacy Policy\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '''
We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page. These changes are effective immediately after they are posted on this page.
''',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              )
                            ]),
                        TextSpan(
                            text: 'Contact Us\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '''
If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us.
 ''',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              )
                            ]),
                      ])),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
