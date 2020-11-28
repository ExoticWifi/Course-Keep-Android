package com.example.CourseKeep.models

import io.realm.RealmObject
import io.realm.annotations.PrimaryKey
import java.util.ArrayList

open class ClassModel(
    @PrimaryKey var id: Int? = 0,
    var className: String? = null,
    var classCode: String? = null,
    var deliveryMethod: String? = null,
    var section: String? = null,
    var hours: Int? = 0,
    var sun: Boolean? = false,
    var mon: Boolean? = false,
    var tue: Boolean? = false,
    var wed: Boolean? = false,
    var thu: Boolean? = false,
    var fri: Boolean? = false,
    var sat: Boolean? = false,
    var days: String? = ""
) : RealmObject() {

}