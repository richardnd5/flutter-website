class WebLinkOption {
  WebLinkOption({
    required this.url,
    required this.label,
    required this.asset,
    this.isNetworkImage = false,
  });
  final String label;
  final String url;
  final String asset;
  final bool isNetworkImage;
}
