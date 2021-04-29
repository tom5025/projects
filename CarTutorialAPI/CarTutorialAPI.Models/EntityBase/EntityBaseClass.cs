using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace CarTutorialAPI.Models.EntityBase
{
    public class EntityBaseClass
    {
        [Key]
        public long Id { get; set; }

        public DateTime? Created { get; set; }

        public DateTime? Updated { get; set; }

        public bool Deleted { get; set; }

        public EntityBaseClass()

        {

            Deleted = false;

        }

        public virtual int IdentityID()

        {

            return 0;

        }

        public virtual object[] IdentityID(bool dummy = true)

        {

            return new List<object>().ToArray();

        }

    }

}
