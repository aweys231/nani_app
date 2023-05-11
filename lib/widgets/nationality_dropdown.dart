// ignore_for_file: prefer_const_constructors, implementation_imports, unnecessary_import, unused_import, import_of_legacy_library_into_null_safe, deprecated_member_use, unused_local_variable, prefer_const_literals_to_create_immutables, avoid_print

// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:dropdown_search2/dropdown_search2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nanirecruitment/providers/candidate_registration.dart';
import 'package:provider/provider.dart';

class Natitinality extends StatefulWidget {
  const Natitinality({super.key, required this.onChanged});
  final ValueChanged<dynamic> onChanged;

  @override
  State<Natitinality> createState() => _NatitinalityState();
}

class _NatitinalityState extends State<Natitinality> {
 final TextEditingController searchContentSetor = TextEditingController();
  String dropdownValue = 'NO';
  @override
void dispose() {
  searchContentSetor.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    
     Provider.of<Candidate>(context).fetchAndSetnatinality();
     final nationality = Provider.of<Candidate>(context, listen: false);
    return  Container(
      margin: const EdgeInsets.only(bottom: 15, top: 5),
      height: 60,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField2<String>(
          decoration: InputDecoration(
           labelText: 'choose Nationality',
                   enabledBorder: OutlineInputBorder(
                     //<-- SEE HERE
                     borderSide: BorderSide(
                         color: Color.fromARGB(255, 162, 159, 159), width: 1),
                   ),
                   focusedBorder: OutlineInputBorder(
                     //<-- SEE HERE
                     borderSide: BorderSide(
                         color: Color.fromARGB(255, 162, 159, 159), width: 1),
                   ),
                   filled: true,
                 ),
                 // decoration: FormStyles.textFieldDecoration(labelText: 'Region'),
                 hint: const Text(
                   'choose Nationality',
                 ),
                          
                           isExpanded: true,
                           // icon: const Icon(Icons.arrow_downward),
                             items:  nationality.nationality.map((data) {
                 return DropdownMenuItem<String>(
                   value: data.id,
                   child: Text(
                     data.name,
                     style: const TextStyle(fontSize: 12),
                   ),
                 );
               }).toList(),
                    
                    onChanged: (v) => widget.onChanged(v),
                         
                  dropdownSearchData: DropdownSearchData(
                   searchController: searchContentSetor,
                   searchInnerWidgetHeight: 50,
                   searchInnerWidget: Container(
                     height: 50,
                     padding: const EdgeInsets.only(
                       top: 8,
                       bottom: 4,
                       right: 8,
                       left: 8,
                     ),
                             child: TextFormField(
                               controller: searchContentSetor,
                               autocorrect: false,
                                keyboardType: TextInputType.text,
                               decoration: InputDecoration(
                                 isDense: false,
                                 contentPadding: const EdgeInsets.symmetric(
                                   horizontal: 8,
                                   vertical: 8,
                                 ),
                                 labelText: 'choose Nationalit',
                                 hintText: 'choose Nationalit...',
                                 counterText: '',
                                 hintStyle: const TextStyle(fontSize: 16),
                                 border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(8),
                                 ),
                               ),
                             ),
                           ),
                            searchMatchFn: (item, searchValue) {        
                   return (item.child.toString().toLowerCase().contains(searchValue));
                 }, ),
                           //This to clear the search value when you close the menu
                           onMenuStateChange: (isOpen) {
                             if (!isOpen) {
                               searchContentSetor.clear();
                             }
                           },
                         ),
      )
    );
  }
}
