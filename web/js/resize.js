   
    $(document).ready(function () {
                $('#sidebarCollapse').on('click', function () {
                    $('#sidebar').toggleClass('active');
                });
            });
            function Init(){
                 if (this.resizeTO)
                    clearTimeout(this.resizeTO);
                this.resizeTO = setTimeout(function () {
                    $(this).trigger('resizeEnd');
                }, 0);
            }
            $(window).resize(function () {
                if (this.resizeTO)
                    clearTimeout(this.resizeTO);
                this.resizeTO = setTimeout(function () {
                    $(this).trigger('resizeEnd');
                }, 0);
            });

            $(window).bind('resizeEnd', function () {
                var wrapper=document.getElementById("wrapper");
                wrapper.style.height=window.innerHeight+"px";
            });
