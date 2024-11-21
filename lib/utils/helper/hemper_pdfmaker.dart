// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables

import 'dart:developer';
import 'dart:io';
import 'package:ayushman_bhava/model/patientpost_model.dart';
import 'package:ayushman_bhava/model/treatmentlistmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';

import '../../controller/service/provider/provideroperation.dart';


Future<File> generatePdf(BuildContext context,PatientPost data,List<Treatment> treatmentlist) async {
  final service = Provider.of<ProviderOperation>(context, listen: false);
  PdfPageFormat? pagesize = PdfPageFormat.a4;

  const textgreen = PdfColor.fromInt(0xFF00A64F);
  const textgreylight = PdfColor.fromInt(0xFF9A9A9A);
   final fontData = await rootBundle.load('assets/fonts/Manrope-Regular.ttf');
  final ttf = pw.Font.ttf(fontData);
  final pdf = pw.Document();

final backgroundImage = pw.MemoryImage(
    (await rootBundle.load('assets/images/logotran.png')).buffer.asUint8List(),
  );
  final logocolor = pw.MemoryImage(
    (await rootBundle.load('assets/images/logosmall.png')).buffer.asUint8List(),
  );
  final signature = pw.MemoryImage(
    (await rootBundle.load('assets/images/signature.png')).buffer.asUint8List(),
  );
    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(10),
        pageFormat: pagesize,
        theme: pw.ThemeData(defaultTextStyle:  pw.TextStyle(font: ttf)),
        build: (pw.Context contexts) =>pw.Stack(
          children: [
           pw.Center(
 child:pw.Container(
                width: 414,
                height: 436,
                decoration: pw.BoxDecoration(

                  image: pw.DecorationImage(
                    image: backgroundImage,
                    fit: pw.BoxFit.cover,
                  ),
                ),
              ),
           ),
              
            
          
             pw.Container(
          padding: const pw.EdgeInsets.all(20),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header Section
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Expanded(child: pw. Row(
                    children: [
                      pw.Center(
 child:pw.Container(
                width: 76,
                height: 80,
                decoration: pw.BoxDecoration(

                  image: pw.DecorationImage(
                    image: logocolor,
                    fit: pw.BoxFit.cover,
                  ),
                ),
              ),
           ),
                    ],
                  )
                  ),
                  pw.Expanded(child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        data.branch?.name??'',
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                          
                        ),
                      ),
                      pw.Text("${data.branch?.address??''} ${data.branch?.address??''} \n email ${data.branch?.mail??''} \n phone ${data.branch?.phone??''} \n GST ${data.branch?.gst??''} ",textAlign: pw.TextAlign.right,style: const pw.TextStyle(color: textgreylight)),
                    ],
                  ),
                  )
                  
                  
                  
                ],
              ),
              pw.Divider(color: textgreylight),
              pw.SizedBox(height: 20),

              // Patient Details
              pw.Text(
                "Patient Details",
                style: pw.TextStyle(
                  fontSize: 16,
                  color: textgreen,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(
                        height: 10
                      ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Expanded(child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        children: [
                          pw.Expanded(child: pw.Text('Name',style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                          pw.Expanded(child: pw.Text(data.name??'',style: const pw.TextStyle(color: textgreylight))),
                        ]
                      ),
                      pw.SizedBox(
                        height: 5
                      ),
                      pw.Row(
                        children: [
                          pw.Expanded(child: pw.Text('Address',style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                          pw.Expanded(child: pw.Text(data.address??'',style: const pw.TextStyle(color: textgreylight))),
                        ]
                      ),
                      pw.SizedBox(
                        height: 5
                      ),
                      pw.Row(
                        children: [
                          pw.Expanded(child: pw.Text('WhatsApp Number',style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                          pw.Expanded(child: pw.Text(data.phone??'',style: const pw.TextStyle(color: textgreylight))),
                        ]
                      ),
                      
                    ],
                  ),
                  ),
                  pw.SizedBox(
                        width: 30
                      ),
                  pw.Expanded(child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        children: [
                          pw.Expanded(child: pw.Text('Booked On',style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                          pw.Expanded(child: pw.Text(data.dateNdTime??'',style: const pw.TextStyle(color: textgreylight))),
                        ]
                      ),
                      pw.SizedBox(
                        height: 5
                      ),
                      pw.Row(
                        children: [
                          pw.Expanded(child: pw.Text('Treatment Date',style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                          pw.Expanded(child: pw.Text(data.dateNdTime??'',style: const pw.TextStyle(color: textgreylight))),
                        ]
                      ),pw.SizedBox(
                        height: 5
                      ),
                      pw.Row(
                        children: [
                          pw.Expanded(child: pw.Text('Treatment Time',style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                          pw.Expanded(child: pw.Text('11:00',style: const pw.TextStyle(color: textgreylight))),
                        ]
                      ),
                      
                    ],
                  ),
                  ),
                 
                  
                 
                ],
              ),
               pw.SizedBox(height: 20),
              pw.Divider(
                color: textgreylight,
                borderStyle: pw.BorderStyle.dashed
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text("Treatment", style: pw.TextStyle(fontWeight: pw.FontWeight.bold,color: textgreen),textAlign: pw.TextAlign.left), ),
                  pw.Expanded(child: pw.Text("Price", style: pw.TextStyle(fontWeight: pw.FontWeight.bold,color: textgreen),textAlign: pw.TextAlign.left), ),
                  pw.Expanded(child: pw.Text("Male", style: pw.TextStyle(fontWeight: pw.FontWeight.bold,color: textgreen),textAlign: pw.TextAlign.center), ),
                  pw.Expanded(child: pw.Text("Female", style: pw.TextStyle(fontWeight: pw.FontWeight.bold,color: textgreen),textAlign: pw.TextAlign.center), ),
                  pw.Expanded(child: pw.Text("Total", style: pw.TextStyle(fontWeight: pw.FontWeight.bold,color: textgreen),textAlign: pw.TextAlign.right), ),
                ]
              ),
              pw.SizedBox(
                height: 5
              ),
              ...treatmentlist.map((treatment) {
                return  pw.Column(
                  children: [
                    pw.Row(
                children: [
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(treatment.name??'', style: const pw.TextStyle(),textAlign: pw.TextAlign.left), ),
                  pw.Expanded(child: pw.Text("\u{20B9} ${treatment.price}", style: const pw.TextStyle(),textAlign: pw.TextAlign.left), ),
                  pw.Expanded(child: pw.Text("${treatment.male}", style: const pw.TextStyle(),textAlign: pw.TextAlign.center), ),
                  pw.Expanded(child: pw.Text("${treatment.female}", style: const pw.TextStyle(),textAlign: pw.TextAlign.center), ),
                  pw.Expanded(child: pw.Text(" \u{20B9} ${treatment.totalamt}", style: const pw.TextStyle(),textAlign: pw.TextAlign.right), ),
                ]
              ),
               pw.SizedBox(height: 3),
                  ]
                );
              })..toList(),
             
              pw.SizedBox(height: 20),

              // Summary Section
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Expanded(
                    flex: 2,
                    child: pw.SizedBox()),
                   pw.Expanded(child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        children: [
                          pw.Expanded(child: pw.Text('Total Amount',style: pw.TextStyle(fontWeight: pw.FontWeight.bold),textAlign: pw.TextAlign.right)),
                          pw.Expanded(child: pw.Text('\u{20B9} ${data.totalAmount.toString()}',style:  pw.TextStyle(fontWeight: pw.FontWeight.bold),textAlign: pw.TextAlign.right)),
                        ]
                      ),
                      pw.SizedBox(
                        height: 5
                      ),
                      pw.Row(
                        children: [
                          pw.Expanded(child: pw.Text('Dscount',style: const pw.TextStyle(),textAlign: pw.TextAlign.right)),
                          pw.Expanded(child: pw.Text('\u{20B9} ${data.discountAmount.toString()}',style:  const pw.TextStyle(),textAlign: pw.TextAlign.right)),
                       ]
                      ),pw.SizedBox(
                        height: 5
                      ),
                      pw.Row(
                        children: [
                            pw.Expanded(child: pw.Text('Advance',style: const pw.TextStyle(),textAlign: pw.TextAlign.right)),
                          pw.Expanded(child: pw.Text('\u{20B9} ${data.advanceAmount.toString()}',style:  const pw.TextStyle(),textAlign: pw.TextAlign.right)),
                        ]
                      ),
                      pw.Divider(color: textgreylight,borderStyle: pw.BorderStyle.dashed),
                      pw.Row(
                        children: [
                            pw.Expanded(child: pw.Text('Balance',style: const pw.TextStyle(),textAlign: pw.TextAlign.right)),
                          pw.Expanded(child: pw.Text('\u{20B9} ${data.balanceAmount.toString()}',style:  const pw.TextStyle(),textAlign: pw.TextAlign.right)),
                        ]
                      ),
                    ],
                  ),
                  ),
                 
                ],
              ),
              pw.SizedBox(height: 20),

          
              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 3,
                    child: pw.SizedBox()),
                  pw.Expanded(
                    flex:2 ,
                    child: pw.Column(
                    children: [
                      pw.Text(
                "Thank you for choosing us",
                style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold,color: textgreen,),textAlign: pw.TextAlign.right
              ),
              pw.Text(
                "Your well-being is our commitment, and we're honored you've entrusted us with your health journey",
                textAlign: pw.TextAlign.right,
                style: const pw.TextStyle(color: textgreylight,fontSize: 10)
              ),pw.SizedBox(
                height: 10
              ),
               pw.Center(
 child:pw.Container(
                width: 107,
                height: 41,
                decoration: pw.BoxDecoration(

                  image: pw.DecorationImage(
                    image: signature,
                    fit: pw.BoxFit.cover,
                  ),
                ),
              ),
           ),
                    ]
                  ))
                ]
              )
            ],
          ),
        )
      
          ]
        )),
    );
  

  final Directory? directory = await getExternalStorageDirectory();
  String path = directory!.path;

  //change pdf location using package path:
  // String documentsDirectory =
  //     path.join(path.current, '/storage/emulated/0/Download');

  log('2');
  String fileName = "Patient1.pdf";

  log('3');
  // Save the PDF to a file
  final file = File('$path/$fileName');

  log('4');
  await file.writeAsBytes(await pdf.save());

  log('5');
  OpenFile.open('$path/$fileName');
  log('fileName  : $fileName');
  log('file : $file');
  log('path : $path');

  return file;
}


