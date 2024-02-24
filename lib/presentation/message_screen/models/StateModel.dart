class StateModel {
  StateModel({
    required this.sigla,
    required this.nome,
  });

  String sigla;
  String nome;

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
    sigla: json["sigla"],
    nome: json["nome"],
  );

  Map<String, dynamic> toJson() => {
    "sigla": sigla,
    "nome": nome,
  };

  static List<StateModel> listFromJson(list) =>
      List<StateModel>.from(list.map((x) => StateModel.fromJson(x)));
}