import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.fluttertemplate2025.dev"
            resValue(type = "string", name = "app_name", value = "Flutter Template Dev")
        }
        create("qa") {
            dimension = "flavor-type"
            applicationId = "com.fluttertemplate2025.qa"
            resValue(type = "string", name = "app_name", value = "Flutter Template QA")
        }
        create("uat") {
            dimension = "flavor-type"
            applicationId = "com.fluttertemplate2025.uat"
            resValue(type = "string", name = "app_name", value = "Flutter Template UAT")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.fluttertemplate2025"
            resValue(type = "string", name = "app_name", value = "Flutter Template")
        }
    }
}