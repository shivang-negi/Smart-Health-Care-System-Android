import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MedicinePage extends StatefulWidget {
  String number;
  MedicinePage({Key? key, required this.number}) : super(key: key);

  @override
  State<MedicinePage> createState() => _MedicineState();
}

class _MedicineState extends State<MedicinePage> {

  String text = "";

  var medicines = [
    'Amoxicillin 500 mg',
    'Vitamin D 50,000 IU',
    'Ibuprofen 800 mg',
    'Cetirizine hydrochloride 10 mg',
    'Azithromycin 250 mg ',
    'Albuterol sulfate HFA 90 mcg/act ',
    'Cephalexin 500 mg ',
    'Paracetamol Tablets-IP',
    'Bacitracin Topical',
    'Doxycycline Hyclate',
    'H.P. Acthar Gel',
    'Metoprolol ER',
    'tesamorelin injection',
                  ];

  var medicineImages = [
    'https://5.imimg.com/data5/SELLER/Default/2022/12/LL/JW/ST/108376694/cipmox-amoxicillin-500mg-capsules-500x500.png',
    'https://images-cdn.ubuy.co.in/6360d6f9eb3314256c505ddb-nivagen-pharmaceuticals-vitamin-d3.jpg',
    'https://5.imimg.com/data5/SY/DU/MY-557330/ibuprofen-500x500.jpg',
    'https://5.imimg.com/data5/SELLER/Default/2021/12/VU/UX/EZ/90386132/10mg-cetirizine-hydrochloride-tablets-ip-500x500.jpg',
    'https://5.imimg.com/data5/SELLER/Default/2020/12/LO/TS/ZI/3894606/azithromycin-tablets-250-mg-500x500.jpg',
    'https://www.empr.com/wp-content/uploads/sites/7/2018/12/79136af1dbdc4f37a17c6d01cf2c5b7f-ventolin_291396.jpg',
    'https://genericswow.com/wp-content/uploads/2022/02/phalexin-500mg-cephalexin-capsules-ip-1.jpg',
    'https://integratedlaboratories.in/wp-content/uploads/2022/08/Paracetamol-500mg-Tablets-Intemol-500-2.jpeg',
    'https://5.imimg.com/data5/SELLER/Default/2022/7/LX/MY/YT/21276273/bacitracin-ointment-usp-500x500.jpg',
    'https://cpimg.tistatic.com/04314235/b/5/Doxycycline-Hyclate-Lactic-Acid-Bacillus-Capsule.jpg',
    'https://static01.nyt.com/images/2017/01/29/business/29gret1/29gret1-superJumbo.jpg',
    'https://5.imimg.com/data5/SELLER/Default/2021/3/FN/HY/LO/2938236/whatsapp-image-2021-03-17-at-2-41-14-pm-2--1000x1000.jpeg',
    'https://img2.exportersindia.com/product_images/bc-full/dir_187/5592065/tesamorelin-10mg-1522267786-3753580.png'
  ];

  var prices = ['₹ 1100','₹ 900','₹ 1500','₹ 2100','₹ 500','₹ 1900','₹ 300','₹ 200','₹ 150','₹ 1650','₹ 830','₹ 1150','₹ 8500'];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget get() {
    if(text.isEmpty) {
      return const Text('');
    } else {
      text = text.toLowerCase();
      var len = text.length;
      var meds = [], medsImage = [], p = [];
      for(var i=0;i<13;i++) {
        if(len>medicines[i].length) continue;
        String cur = medicines[i].substring(0,len);
        cur = cur.toLowerCase();
        if(cur==text) {
          meds.add(medicines[i]);
          medsImage.add(medicineImages[i]);
          p.add(prices[i]);
        }
      }
      if(meds.isEmpty) {
        return const Center(
          heightFactor: 10,
          child: Text('No Matching Results.',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: Color(0xFF000000),
            ),
          ),
        );
      }
      else {
        return ListView.builder(
          itemCount: meds.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          itemBuilder: (context,index) {
            return Container(
              height: 80,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  ListTile(
                      leading: Container(
                        width: 60,
                        height: 60,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: medsImage[index],
                          height: 100,
                          width:  100,
                          fit: BoxFit.fill,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                      title: Text(meds[index],
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold
                        ),
                      ),
                  )
                  ,SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child:   OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          side: const BorderSide(width: 0.0, color: Colors.transparent)
                      ),
                      child: const Text(''),
                      onPressed: () {
                        // Navigator.push(context,MaterialPageRoute(builder: (context)=> ChatUI(
                        //     user: _user,
                        //     receiver: number[index].toString(),
                        //     receiver_name: name[index],
                        //     path: path
                        // )));
                        print(meds[index]);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1285),
        automaticallyImplyLeading: false,
        leading: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: const Color(0xFF1E1285),
              fixedSize: const Size(50,50)
          ),
          child: const Icon(Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,),
        ),
        title: const Text(
          'Medicine',
          style: TextStyle(
            fontFamily: 'Lexend',
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [],
        centerTitle: false,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        children: [
          Padding(padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: Container(
              width: 100,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0x0fffffff),
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                    child: Icon(Icons.search,
                        color: Colors.black,
                        size: 30,),
                    ),
                  Expanded(
                    child: Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: TextFormField(
                        autofocus: false,
                        obscureText: false,
                        decoration: const InputDecoration(
                          hintText: 'Search Medicines & Health Products.',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            color: Color(0xFF57636C),
                            fontWeight: FontWeight.bold,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: true,
                          fillColor: Color(0x0fffffff),
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: (String str) {
                          text = str;
                          setState(() {});
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          get()
        ],
      ),
    );
  }
}


class AddMedicine extends StatefulWidget {
  const AddMedicine({Key? key}) : super(key: key);

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

