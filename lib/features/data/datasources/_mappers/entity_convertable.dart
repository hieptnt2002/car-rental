mixin EntityConvertable<I, O> {
  O toEntity();
  I fromEntity(O entity) => throw UnimplementedError();
}
