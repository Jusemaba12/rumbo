/// Enlace mailto: abre la app de correo con el borrador puesto.
Uri mailtoUri({
  required String to,
  required String subject,
  required String body,
}) => Uri(
  scheme: 'mailto',
  path: to,
  // Uri codifica los espacios como «+»; algunos clientes no lo entienden.
  query: <String>[
    'subject=${Uri.encodeComponent(subject)}',
    'body=${Uri.encodeComponent(body)}',
  ].join('&'),
);
