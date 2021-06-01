import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class HowItWorks extends StatelessWidget {
  static const routeName = '/howitworks';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('How it works'),
      ),
      drawer:AppDrawer(),
      body: Column(mainAxisAlignment:MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
         // Text('Booking',style: TextStyle(fontSize:20,fontWeight:FontWeight.bold),textAlign:TextAlign.left),
          //SizedBox(height: 5),
          Text('Booking',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
          
          Text('Choose the required service from the given list.'),
          SizedBox(height: 5),
          Text('As soon as the booking is completed, the worker contacts the client for the confirmation of the address and the timings.'),
          SizedBox(height: 5),
          Text('Also, the worker takes more details about the job through a phone call, so as to bring the required tools and equipment'),
          SizedBox(height: 20),
          Text('Charges and Cost',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
          
          Text('All the Rates mentioned are the per the booking charges and total cost is calculated on the basis of time taken to complete the task.'),
          SizedBox(height: 5),
          Text('Booking charges are non-refundable in case of cancellation.'),
          SizedBox(height: 5),
          Text('Any tools required for the repairs/installation will be brought by the worker himself, whereas the cost of any new products to be installed will be borne by the client only.'),
          SizedBox(height: 5),
          Text('No worker’s travelling expenses are to be paid by the client.'),
          SizedBox(height: 5),
          Text(
              'Payment for the worker can be done either by the cash or by online on 9034444449.'),
          SizedBox(height: 70),
          Text(
              'If you have any issues and complaints send us an email at doneright@gmail.com. It will be dealt by our team immediately.',style:TextStyle(fontWeight:FontWeight.bold))
        ],
      ),
    );
  }
}
