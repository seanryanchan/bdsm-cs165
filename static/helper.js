function toggleEdit() {
    if ($(".editableSectionA").css("display") === "none") {
        $(".editableSectionA").show();
        $(".editableSectionB").hide();
    } else{
        $(".editableSectionA").hide();
        $(".editableSectionB").show();
    }
}
