## Required for media_store_plus (used by FCPPdfDownloadService on Android).
## Flutter release builds enable R8 minification by default; without these rules
## Gson serialization in media_store_plus fails and PDF downloads return null.

# Gson uses generic type information stored in a class file when working with fields.
-keepattributes Signature
-keepattributes *Annotation*

-dontwarn sun.misc.**

-keep class * extends com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

-keepclassmembers,allowobfuscation class * {
  @com.google.gson.annotations.SerializedName <fields>;
}

-keep,allowobfuscation,allowshrinking class com.google.gson.reflect.TypeToken
-keep,allowobfuscation,allowshrinking class * extends com.google.gson.reflect.TypeToken

-keep class com.snnafi.media_store_plus.** { *; }
