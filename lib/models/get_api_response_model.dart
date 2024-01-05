class GetApiResponse{/****This is for response with mixed type like data:[],meta:{}}]***/
  late final List<Map<String,dynamic>> data;
  late Map<String,dynamic>? meta;

  GetApiResponse({required this.data,  this.meta});
  GetApiResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> data1=json['data'];
    var x=data1.map((dynamic e) => e as Map<String, dynamic>).toList();
    data =x ;
    meta = json['meta'];


  }

}
/****Bewlow are for general type common in most api call*****
 * data:PlainString,
 * data:[]   List
 * or data:{}  as Map
 */

class GetSingleApiResponse{   /**data:{mesage:{SoemSingleRow}}  as Map***/
  late final Map<String,dynamic> data;

  GetSingleApiResponse({required this.data});
  GetSingleApiResponse.fromJson(Map<String, dynamic> json) {
    dynamic data1=json['data'];
    var x=data1 as Map<String, dynamic>;
    data =x ;



  }

}
class GetPlainStringResponse{ /**data:{mesage:'Successguly added'}  as Map***/
  late final String data;

  GetPlainStringResponse({required this.data});
  GetPlainStringResponse.fromJson(Map<String, dynamic> json) {
    data=json['data'] as String;
  }

}
class GetDataApiResponse{  /**data:[] list of Row***/
  late final List<Map<String,dynamic>> data;

  GetDataApiResponse({required this.data});
    GetDataApiResponse.fromJson(Map<String, dynamic> json) {
      List<dynamic> data1=json['data'];
      var x=data1.map((dynamic e) => e as Map<String, dynamic>).toList();
      data =x ;
     }

}